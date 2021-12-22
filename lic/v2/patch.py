#!/usr/bin/env python3

# Replace a string in a bunch of files
# 21/12/2021
#

# Beware CRLF vs LF. Always LF.

import os
import sys
from shutil import copyfile

def backup(filename, suffix):
    """Copy the original filename to filename.bak."""
    copyfile(filename, filename+suffix)


def searchkey(filename, bstr):
    """Scan a file for the requested string."""
    with open(filename, 'rb') as f:
        s = f.read()

    return bstr in s


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
    back_suffix = ".bak"

    if len(sys.argv) < 2:
        print("Usage: {} software_path".format(sys.argv[0]))
        exit(1)

    workdir = sys.argv[1]

    for root, dirs, files in os.walk(workdir):
        for file in files:
            if back_suffix in file:
                continue

            filename = root + os.sep + file
            #print("Analizando " + filename)

            if searchkey(filename, old):
                print("Clave pública encontrada en '{}'.".format(filename))
                backup(filename, back_suffix)
                replace(filename, old, new)


if __name__ == "__main__":
    main()

