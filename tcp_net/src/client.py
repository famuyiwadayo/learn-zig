#!/usr/bin/env python

import socket

'''CLIENT CODE'''

# Create a TCP/IP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Connect the socket to the port where the server is listening
server_address = ('localhost', 8080)
print(f'connecting to {server_address}')
sock.connect(server_address)

try:
    
    # Send data
    # while True:
    message = input("Messsage: ")
    print(f'sending :: {message} ::')
    sock.sendall(str.encode(message))

        # Look for the response
        # amount_received = 0
        # amount_expected = len(message)
        
        # while amount_received < amount_expected:
        #     data = sock.recv(1 << 10)
        #     amount_received += len(data)
        #     print(f'received {data}')

finally:
    print('closing socket')
    sock.close()