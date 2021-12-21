#!/usr/bin/env python3

# Replace a string in a file
# 21/12/2021
# for /r %i in (..\IDE\bin\*.*) do python patch.py %i

# Beware CRLF vs LF. Always LF.

import sys
from shutil import copyfile

def backup(filename, suffix = ".bak"):
    """Copy the original filename to filename.bak."""
    copyfile(filename, filename+suffix)


def searchkey(filename, bstr):
    """Scan a file for the requested string."""
    with open(filename, 'rb') as f:
        s = f.read()

    return s.find(bstr)


def replace(filename, bsrc, bdst):
    """Replace in-place src with dst in filename."""
    with open(filename,"rb") as f:
        s = f.read()

    s = s.replace(bsrc, bdst)
    
    with open(filename,"wb") as f:
        f.write(s)


def read_key(filename):
    """Read a public RSA key from a file (kind of). Replace \r\n by \n if any."""
    with open(filename, 'rb') as f:
        k = f.read()

    k = k.strip()
    k = k.replace(b'\r',b'')

    return k


def main():
    old = read_key("pubkey_orig.pem")
    new = read_key("pubkey_new.pem")

    if len(sys.argv) < 2:
        print("Usage: {} filename.exe".format(sys.argv[0]))
        exit(1)

    filename = sys.argv[1]

    print("Analizando '{}'...".format(filename))

    if searchkey(filename, old):
        print("Clave pública encontrada en '{}'. Reemplazando.".format(filename))
        #backup(filename)
        replace(filename, old, new)
    else:
        print("Clave no encontrada.")


if __name__ == "__main__":
    main()

