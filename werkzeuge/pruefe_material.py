#!/usr/bin/env python3
"""Lesende Prüfung der lokalen Links und Prüfsummen. Python 3, keine Zusatzpakete."""
from pathlib import Path, PurePosixPath
from urllib.parse import urlsplit, unquote
from html import unescape
from zipfile import ZipFile
import hashlib, re, sys, json, argparse

def prose(text):
    out=[];fence=None
    for line in text.splitlines():
        m=re.match(r'^\s*(`{3,}|~{3,})',line)
        if m:
            if fence is None:fence=(m[1][0],len(m[1]))
            elif m[1][0]==fence[0] and len(m[1])>=fence[1]:fence=None
            out.append('');continue
        out.append('' if fence else line)
    return '\n'.join(out)

def anchors(text):
    result=set();counts={}
    for line in prose(text).splitlines():
        m=re.match(r'^#{1,6}\s+(.+?)\s*#*$',line)
        if not m:continue
        s=unescape(re.sub(r'<[^>]+>','',m[1])).lower()
        s=re.sub(r'\[([^\]]+)\]\([^)]*\)',r'\1',s)
        s=re.sub(r'[^\w\- ]','',s);s=s.replace(' ','-')
        count=counts.get(s,0);counts[s]=count+1
        result.add(s+('-'+str(count) if count else ''))
    result.update(re.findall(r'<a\s+(?:id|name)=["\']([^"\']+)',text))
    return result

def links(text):
    t=prose(text)
    for m in re.finditer(r'\]\(<?([^\s)>]+)>?(?:\s+["\'][^)]*)?\)',t):yield m[1]
    for m in re.finditer(r'(?m)^\[[^\]]+\]:\s*<?([^\s>]+)>?',t):yield m[1]
    for m in re.finditer(r'<(?:img|a)\b[^>]+(?:src|href)=["\']([^"\']+)',t):yield m[1]

def check(root):
    root=root.resolve();errors=[];checked=0;mds=list(root.rglob('*.md'));cache={}
    for p in mds:
        if '.git' in p.relative_to(root).parts:continue
        for link in links(p.read_text(encoding='utf-8')):
            u=urlsplit(link)
            if u.scheme or u.netloc:continue
            path=unquote(u.path);dest=(p.parent/path).resolve() if path else p.resolve();checked+=1
            if not dest.is_relative_to(root):errors.append([str(p.relative_to(root)),link,'außerhalb des Pakets']);continue
            if not dest.exists():errors.append([str(p.relative_to(root)),link,'Datei fehlt']);continue
            if u.fragment and dest.suffix=='.md':
                if dest not in cache:cache[dest]=anchors(dest.read_text(encoding='utf-8'))
                if unquote(u.fragment) not in cache[dest]:errors.append([str(p.relative_to(root)),link,'Abschnitt fehlt'])
    checksum_files=([root/'DATEIEN.sha256'] if (root/'DATEIEN.sha256').exists() else [])
    checksum_files+=sorted(p for p in root.rglob('SHA256SUMS.txt') if '.git' not in p.relative_to(root).parts)
    for p in checksum_files:
        if p.exists():
            for row in p.read_text().splitlines():
                if not row.strip():continue
                try:expected,rel=row.split('  ',1)
                except ValueError:
                    errors.append([str(p.relative_to(root)),row,'Ungültige Prüfsummenzeile']);continue
                target=(p.parent/rel).resolve()
                if not target.is_relative_to(root):
                    errors.append([str(p.relative_to(root)),rel,'außerhalb des Pakets']);continue
                if not target.is_file() or hashlib.sha256(target.read_bytes()).hexdigest()!=expected:errors.append([str(p.relative_to(root)),rel,'Prüfsumme stimmt nicht'])
    manifests=0;manifest_files=0;zip_files=0;zip_members=0
    for p in sorted(root.rglob('manifest.json')):
        if '.git' in p.relative_to(root).parts:continue
        try:
            data=json.loads(p.read_text(encoding='utf-8'))
            if 'band' not in data or 'files' not in data:continue
            manifests+=1;seen=set()
            for item in data['files']:
                rel=item['path'];target=(p.parent/rel).resolve();manifest_files+=1
                if rel in seen:errors.append([str(p.relative_to(root)),rel,'Doppelter Manifesteintrag'])
                seen.add(rel)
                if not target.is_relative_to(p.parent.resolve()):
                    errors.append([str(p.relative_to(root)),rel,'außerhalb des Bandpakets']);continue
                if not target.is_file():
                    errors.append([str(p.relative_to(root)),rel,'Manifestdatei fehlt']);continue
                raw=target.read_bytes()
                if len(raw)!=item['bytes'] or hashlib.sha256(raw).hexdigest()!=item['sha256']:
                    errors.append([str(p.relative_to(root)),rel,'Manifestinhalt stimmt nicht'])
            actual={f.relative_to(p.parent).as_posix() for f in p.parent.rglob('*') if f.is_file() and f!=p}
            if actual!=seen:errors.append([str(p.relative_to(root)),'','Manifest-Dateimenge unvollständig oder überzählig'])
            for item in data.get('sources',[]):
                target=(p.parent.parent/item['destination']).resolve()
                if not target.is_relative_to(p.parent.resolve()) or not target.is_file():
                    errors.append([str(p.relative_to(root)),item['destination'],'Quellzuordnung hat kein Bandziel']);continue
                if hashlib.sha256(target.read_bytes()).hexdigest()!=item['sha256']:
                    errors.append([str(p.relative_to(root)),item['destination'],'Quellziel stimmt nicht'])
        except (ValueError,KeyError,TypeError,OSError) as exc:
            errors.append([str(p.relative_to(root)),'','Manifest nicht prüfbar: '+str(exc)])
    for p in sorted(root.rglob('*.zip')):
        if '.git' in p.relative_to(root).parts:continue
        zip_files+=1
        try:
            with ZipFile(p) as z:
                names=set();contents={}
                for info in z.infolist():
                    if info.filename in names:errors.append([str(p.relative_to(root)),info.filename,'Doppeltes ZIP-Mitglied'])
                    names.add(info.filename)
                    if info.is_dir():continue
                    zip_members+=1;contents[info.filename]=z.read(info)
                    member=PurePosixPath(info.filename)
                    if member.is_absolute() or '..' in member.parts or '\\' in info.filename:
                        errors.append([str(p.relative_to(root)),info.filename,'Unsicherer Mitgliedspfad'])
                embedded=[n for n in contents if n.endswith('/DATEIEN.sha256')]
                if embedded:
                    # Frühere Webhosting-Pakete sind eigenständige datierte Ausgaben
                    # mit einem gemeinsamen äußeren Ordner und eigener Navigation.
                    if len(embedded)!=1:
                        errors.append([str(p.relative_to(root)),'','Mehrdeutige eingebettete Prüfsummenliste']);continue
                    checksum=embedded[0];prefix=checksum.rsplit('/',1)[0]+'/';expected_members={checksum}
                    for row in contents[checksum].decode('utf-8').splitlines():
                        if not row.strip():continue
                        expected,rel=row.split('  ',1);member=prefix+rel
                        if member in expected_members:
                            errors.append([str(p.relative_to(root)),member,'Doppelte eingebettete Prüfsumme'])
                        expected_members.add(member)
                        if member not in contents or hashlib.sha256(contents[member]).hexdigest()!=expected:
                            errors.append([str(p.relative_to(root)),member,'Eingebettete Prüfsumme stimmt nicht'])
                    if expected_members!=set(contents):
                        errors.append([str(p.relative_to(root)),'','ZIP-Dateimenge passt nicht zur eigenen Prüfsummenliste'])
                else:
                    band=re.search(r'_Band_([123])_',p.name)
                    bandroot=p.parent.parent/('band-'+band[1]) if band else None
                    if bandroot is None or not (bandroot/'manifest.json').is_file():
                        errors.append([str(p.relative_to(root)),'','ZIP hat kein zugeordnetes Bandmanifest'])
                    else:
                        expected_members={f.relative_to(p.parent.parent).as_posix() for f in bandroot.rglob('*') if f.is_file()}
                        if set(contents)!=expected_members:
                            errors.append([str(p.relative_to(root)),'','ZIP-Dateimenge passt nicht zum vollständigen Bandpaket'])
                    for member,raw in contents.items():
                        target=(p.parent.parent/member).resolve()
                        if not target.is_relative_to(root) or not target.is_file():
                            errors.append([str(p.relative_to(root)),member,'ZIP-Mitglied hat kein örtliches Ziel']);continue
                        if raw!=target.read_bytes():errors.append([str(p.relative_to(root)),member,'ZIP-Inhalt stimmt nicht mit örtlicher Datei überein'])
        except (ValueError,OSError,RuntimeError,EOFError) as exc:
            errors.append([str(p.relative_to(root)),'','ZIP nicht prüfbar: '+str(exc)])
        except Exception as exc:
            # zipfile.BadZipFile und Kompressionsfehler als Befund ausgeben.
            errors.append([str(p.relative_to(root)),'','ZIP beschädigt: '+str(exc)])
    return {'markdown_files':len(mds),'local_links_checked':checked,'checksum_lists':len(checksum_files),'manifests':manifests,'manifest_files':manifest_files,'zip_files':zip_files,'zip_members':zip_members,'errors':errors}

if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--root',type=Path,default=Path(__file__).resolve().parents[1]);args=parser.parse_args()
    report=check(args.root);print(json.dumps(report,ensure_ascii=False,indent=2));sys.exit(bool(report['errors']))
