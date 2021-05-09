#!/usr/bin/python

# Basic license server for educative purpose only.
# You MUST NOT use the software without a proper license.

import socket

HOST = ''
PORT = 10559

def getint(conn):
    '''Read 4 bytes from socket and return them as 32 bit big-endian integer'''
    data = conn.recv(4)
    i = int.from_bytes(data, byteorder='big')
    return i

def marshall(datadict):
    '''Convert a dict into a serialized binary stream'''

    buff = bytearray()

    buff = len(datadict).to_bytes(4, byteorder='big')

    for key, value in datadict.items():
        key_bytes = key.encode('UTF-16BE')
        value_bytes = value.encode('UTF-16BE')
        buff = buff + (
            len(key_bytes).to_bytes(4, byteorder='big') + 
            key_bytes +
            len(value_bytes).to_bytes(4, byteorder='big') + 
            value_bytes
        )

    buff = len(buff).to_bytes(4, byteorder='big') + buff
    return buff


def start():
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.bind((HOST, PORT))
        s.listen()
        
        while True:
            conn, addr = s.accept()
            with conn:
                print('Request from', addr[0])

                length = getint(conn)
                number_of_fields = getint(conn)

                # Fields
                for _ in range(number_of_fields):
                    size = getint(conn)
                    key = conn.recv(size).decode('UTF-16BE')
                    size = getint(conn)
                    value = conn.recv(size).decode('UTF-16BE')
                    print("  {}: {}".format(key, value))

                # answer ok
                response = {'res':'ok'}
                conn.sendall(marshall(response))

if __name__ == "__main__":
    print('Personal license server. Educative purpose only.')
    print('WARNING: You MUST apply for an actual license to use the software.')

    start()
