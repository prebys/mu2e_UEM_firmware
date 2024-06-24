//
// Created by Ryry013 on 5/7/2024.
//
#ifdef _WIN32
//For Windows
int betriebssystem = 1;
#include <winsock2.h>
#include <ws2tcpip.h>
#include <iphlpapi.h>
#include <ws2def.h>
#pragma comment(lib, "Ws2_32.lib")
#include <windows.h>
#include <io.h>

#else
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
int betriebssystem = 2;
#endif

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <iostream>
#include <fstream>
#include <string>
#include <unistd.h>
using namespace std;


#define BUFSIZE 900000
#define SERVICE_PORT 48879

int main(int argc, char **argv)
{
    struct sockaddr_in myaddr;      /* our address */
    struct sockaddr_in remaddr;     /* remote address */
    socklen_t addrlen = sizeof(remaddr);            /* length of addresses */
    int recvlen;                    /* # bytes received */
    int fd;                         /* our socket */
    unsigned char buf[BUFSIZE];     /* receive buffer */
    int event = 0;
    int subevent = 0;
    int counter = 0;
    string line;

    ofstream myfile("test.dat");

    /* create a UDP socket */
    if ((fd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
        perror("cannot create socket\n");
        return 0;
    }

    /* bind the socket to any valid IP address and a specific port */
    memset((char *)&myaddr, 0, sizeof(myaddr));
    myaddr.sin_family = AF_INET;
    myaddr.sin_addr.s_addr = htonl(INADDR_ANY);
    myaddr.sin_port = htons(SERVICE_PORT);

    if (bind(fd, (struct sockaddr *)&myaddr, sizeof(myaddr)) < 0) {
        perror("bind failed");
        return 0;
    }

    printf("waiting on port %d\n", SERVICE_PORT);
    /* now loop, receiving data and printing what we received */
    while (true) {
//        printf("[%d] fd: %d\n", counter, fd);
        counter++;
        recvlen = recvfrom(fd, reinterpret_cast<char *>(buf), BUFSIZE, 0, (struct sockaddr *)&remaddr, &addrlen);
//        printf("received %d bytes\n", recvlen);

        for (int i=0; i<recvlen; i++){
            myfile << buf[i];
        }

        // Get the current position of the put pointer
        streamoff fileSize = myfile.tellp();

        // Convert the size from bytes to megabytes
        double fileSizeInMB = fileSize / 1048576.0;

        if (recvlen > 0) {
            buf[recvlen] = 0;

            printf("%.2x %.2x %.2x %.2x \t %.2x %.2x %.2x %.2x [ ... ] \n "
                   "%.2x %.2x %.2x %.2x \t %.2x %.2x %.2x %.2x \n",
                   buf[0], buf[1], buf[2], buf[3],
                   buf[4], buf[5], buf[6], buf[7],
                   buf[recvlen-8], buf[recvlen-7], buf[recvlen-6], buf[recvlen-5],
                   buf[recvlen-4], buf[recvlen-3], buf[recvlen-2], buf[recvlen-1]);

            if(buf[0] == 0xff && buf[1] == 0xff && buf[2] == 0xff && buf[3] == 0xff) {
                event++;
                subevent = buf[16] & 0xff;
                // printf("event = %d subevent = %d \n", event, subevent);
            } else if(buf[0] == 0x00 && buf[1] == 0xff && buf[2] == 0xff && buf[3] == 0xff) {
                subevent = buf[12] & 0xff;
                // printf("sub event = %d\n", subevent);
                // printf("File size: %zu", myfile.tellp())
            }

            printf("[%d] event = %d, sub event = %d (file size = %.2f MB)\n", counter, event, subevent,
                   fileSizeInMB);
        }
    }
    /* never exits */
}
