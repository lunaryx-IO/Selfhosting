#!/usr/bin/python3
import grp
import os
import pwd
import stat
import sys
from pathlib import Path

if os.geteuid() != 0 or len(sys.argv) != 3:
    raise SystemExit("Aufruf als root: werkpost-restore-rechte RESTOREPFAD plan|anwenden")
base = Path(sys.argv[1]).resolve()
mode = sys.argv[2]
if base.parent != Path("/root") or not base.name.startswith("werkpost-rueckholung"):
    raise SystemExit("Nur eine eigene Restorekopie direkt unter /root ist erlaubt")
if mode not in ("plan", "anwenden"):
    raise SystemExit("Unbekannter Modus")
marker = base / ".werkpost-rechte-zugeordnet"
if marker.exists():
    raise SystemExit("Diese Arbeitskopie wurde bereits zugeordnet")

def names(path, index):
    result = {}
    for line in path.read_text().splitlines():
        fields = line.split(":")
        number = int(fields[index])
        if number in result and result[number] != fields[0]:
            raise SystemExit("Mehrdeutige alte Identitaet: " + str(number))
        result[number] = fields[0]
    return result

meta = base / "var/lib/werkpost-sicherung"
users = names(meta / "systemkonten.txt", 2)
groups = names(meta / "systemgruppen.txt", 2)
roots = [
    "srv/mail", "etc/dovecot", "etc/postfix", "etc/letsencrypt",
    "etc/aliases", "etc/aliases.db", "var/spool/postfix",
    "var/lib/postfix", "var/lib/dovecot", "etc/rspamd",
    "var/lib/rspamd", "etc/redis", "var/lib/redis",
]
paths = []
for relative in roots:
    root = base / relative
    if not root.exists() and not root.is_symlink():
        continue
    if root.is_symlink():
        raise SystemExit("Unerwartete Verknuepfung am Teilbaum: " + relative)
    paths.append(root)
    if root.is_dir():
        for directory, dirs, files in os.walk(root, followlinks=False):
            paths.extend(Path(directory) / name for name in dirs + files)

plan = []
for path in paths:
    old = path.lstat()
    try:
        username, groupname = users[old.st_uid], groups[old.st_gid]
        newuid = pwd.getpwnam(username).pw_uid
        newgid = grp.getgrnam(groupname).gr_gid
    except KeyError as error:
        raise SystemExit("Identitaet fehlt; Pakete/Zuordnung klaeren: " + str(error))
    plan.append((path, newuid, newgid, stat.S_IMODE(old.st_mode),
                 stat.S_ISLNK(old.st_mode), old.st_uid, old.st_gid))

changes = sum((u, g) != (ou, og) for _, u, g, _, _, ou, og in plan)
print("Erfasste Objekte:", len(plan), "abweichende Zuordnungen:", changes)
for path, uid, gid, permissions, link, olduid, oldgid in plan:
    if mode == "anwenden":
        os.chown(path, uid, gid, follow_symlinks=False)
        if not link:
            os.chmod(path, permissions)
if mode == "anwenden":
    marker.write_text("Eigentuemer nach Namen auf diesen Ersatz zugeordnet.\n")
    marker.chmod(0o600)
