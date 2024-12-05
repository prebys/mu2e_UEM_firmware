CC=g++
CFLAGS = -g
# uncomment this for SunOS
# LIBS = -lsocket -lnsl

all: testudpsocket udp-recv UDPClient

testudpsocket: testudpsocket.o 
	$(CC) -o testudpsocket testudpsocket.o $(LIBS) 
udp-recv: udp-recv.o 
	$(CC) -o udp-recv udp-recv.o $(LIBS)
UDPClient: UDPClient.o 
	$(CC) -o UDPClient UDPClient.o $(LIBS)

udp-send.o: udp-send.c port.h
udp-recv.o: udp-recv.c port.h
UDPClient.o: UDPClient.c
clean:
	rm -f testudpsocket udp-recv UDPClient testudpsocket.o udp-recv.o UDPClient.o
