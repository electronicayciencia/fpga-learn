LIC="#---------------------------------------------------------------
# GOWIN LICENSE
#
# WARNING: This file must not be edited in any way.
#---------------------------------------------------------------

MODE = NODELOCK
TYPE = STD
HOST_ID = xxxxxxxxxxxx
EXP_DATE = 2050-10-26
"

#MODE = FLOATING
#TYPE = STD
#HOST_ID = xxxxxxxxxxxx
#EXP_DATE = 2022-10-26
#COUNT = 50

echo "$LIC"
echo "-------------------------- BEGIN SIGN --------------------------"
echo "$LIC" | openssl dgst -sha256 -sign privkey_new.pem | xxd -p -c 32
echo "--------------------------- END SIGN ---------------------------"

