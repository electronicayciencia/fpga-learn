#!/usr/bin/python

# Basic license server for educative purpose only.
# You MUST NOT use the software without a proper license.

import socketserver

class RequestHandler(socketserver.BaseRequestHandler):

    def handle(self):
        print("Request from", self.client_address[0], "with data:")

        length = int.from_bytes(self.request.recv(4), byteorder='big')
        number_of_fields = int.from_bytes(self.request.recv(4), byteorder='big')

        # Fields
        for _ in range(number_of_fields):
            size = int.from_bytes(self.request.recv(4), byteorder='big')
            key = self.request.recv(size).decode('UTF-16BE')
            size = int.from_bytes(self.request.recv(4), byteorder='big')
            value = self.request.recv(size).decode('UTF-16BE')
            
            print("  {}: {}".format(key, value))

        # answer: ok, lic_expired, no_such_lic, no_more_lic
        response_data = {'res':'ok'}
        self.answer(response_data)


    def answer(self, data):
        '''Convert a dict into a serialized binary stream'''
        print('Response:\n  ', data)

        buff = bytearray()
        buff = len(data).to_bytes(4, byteorder='big')

        for key, value in data.items():
            key_bytes = key.encode('UTF-16BE')
            buff = buff + len(key_bytes).to_bytes(4, byteorder='big')
            buff = buff + key_bytes

            value_bytes = value.encode('UTF-16BE')
            buff = buff + len(value_bytes).to_bytes(4, byteorder='big')
            buff = buff + value_bytes

        buff = len(buff).to_bytes(4, byteorder='big') + buff
        self.request.sendall(buff)


if __name__ == "__main__":
    print('Personal license server. Educational purpose only.')
    print('WARNING: You MUST apply for an actual license to use the software.')
    print('WARNING: Do NOT use any software without the required license.')
    
    HOST, PORT = "0.0.0.0", 10559

    with socketserver.TCPServer((HOST, PORT), RequestHandler) as server:
        server.serve_forever()
