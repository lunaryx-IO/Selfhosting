#!/usr/bin/env python3
"""Lesende Prüfung der lokalen Links und Prüfsummen. Python 3, keine Zusatzpakete."""
from pathlib import Path
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
    for p in [root/'DATEIEN.sha256',root/'pakete/SHA256SUMS.txt']:
        if p.exists():
            for row in p.read_text().splitlines():
                expected,rel=row.split('  ',1);target=p.parent/rel
                if not target.is_file() or hashlib.sha256(target.read_bytes()).hexdigest()!=expected:errors.append([str(p.relative_to(root)),rel,'Prüfsumme stimmt nicht'])
    for p in (root/'pakete').glob('*.zip') if (root/'pakete').exists() else []:
        with ZipFile(p) as z:
            if z.testzip():errors.append([str(p.relative_to(root)),'','ZIP beschädigt'])
    return {'markdown_files':len(mds),'local_links_checked':checked,'errors':errors}

if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--root',type=Path,default=Path(__file__).resolve().parents[1]);args=parser.parse_args()
    report=check(args.root);print(json.dumps(report,ensure_ascii=False,indent=2));sys.exit(bool(report['errors']))
