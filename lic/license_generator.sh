#!/bin/bash

# TYPE = FLOATING                 FLOATING | NODE_LOCK
# HOST = F8BC12552E8C             (mac address)
# TOOL = {gowin, 2016-05-25, 10}  (tool "gowin", expiration date, limit | 0 for NODE_LOCK )

license="#-------------------------------------------------------------
#
# License created by Gowin_LIC_Generator
#
# WARNING: do NOT modify any part of this file.
#
#-------------------------------------------------------------
# license for:
#     client_name: 
#     email_addr: 
#-------------------------------------------------------------


TYPE = FLOATING
HOST = F8BC12552E8C
TOOL = {gowin, 2016-05-25, 10}


"

hash1=$(echo -n "$license" | sha1sum | xxd -r -p | sha1sum | xxd -r -p | sha1sum | cut -d' ' -f1 | tr 'a-z' 'A-Z')
hash2=$(echo -n "$license" | md5sum  | xxd -r -p | sha1sum | xxd -r -p | sha1sum | cut -d' ' -f1 | tr 'a-z' 'A-Z')
hash3=$(echo -n "$license" | md5sum  | xxd -r -p | md5sum  | xxd -r -p | sha1sum | cut -d' ' -f1 | tr 'a-z' 'A-Z')

echo -n "$license"
echo $hash1
echo $hash2
echo $hash3

