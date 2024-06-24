CC=g++
CFLAGS = -g
# uncomment this for SunOS
# LIBS = -lsocket -lnsl

all: clean udp-recv

testudpsocket: testudpsocket.o 
	$(CC) -o testudpsocket testudpsocket.o $(LIBS) 
udp-recv: udp-recv.o 
	$(CC) -o udp-recv udp-recv.o $(LIBS)


udp-send.o: udp-send.c port.h
udp-recv.o: udp-recv.c port.h
udp-recv-savedata-v2.o: udp-recv-savedata-v2.c port.h
clean:
	rm -f testudpsocket udp-recv testudpsocket.o udp-recv.o
