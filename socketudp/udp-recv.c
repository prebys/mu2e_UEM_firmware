// v1.0 (2024/05/07) Created by Ryan Hensley from original udp-recv.c
// v1.1 (2025/01/16) Modify filename to include creation time
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

// General imports
#include <signal.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <iostream>
#include <fstream>
#include <string>
#include <unistd.h>
#include <ctime>
#include <sstream>
using namespace std;


#define BUFSIZE 900000
#define SERVICE_PORT 48879

ofstream myfile;
bool keepRunning = true;
int eventLimit = -1;  // limit of events, default to infinity


// === Helper function to prepend config files ===
void writeFileWithComments(const string &sourceFilename, ofstream &outfile) {
    ifstream infile(sourceFilename.c_str());
    if (!infile.is_open()) {
        cerr << "Warning: Failed to open " << sourceFilename << endl;
        return;
    }

    string line;
    while (getline(infile, line)) {
        outfile << "# " << line << "\n";
    }
    infile.close();
}


string generateFilenameWithDatetime() {
    // Get the current time
    time_t now = time(NULL);
    struct tm *timeinfo = localtime(&now);

    // Format the time as YYYYMMDD_HHMMSS
    char buffer[30];
    strftime(buffer, sizeof(buffer), "data/data_%Y%m%d_%H%M%S.dat", timeinfo);

    return string(buffer);
}



void handleSigint(int sig) {
    cout << "\nClosing file and exiting...\n";
    if (myfile.is_open()) {
        myfile.close();
    }
    exit(0); // Exit the program
}

int main(int argc, char **argv)
{
    signal(SIGINT, handleSigint);  // Register signal handler

    if (argc > 1) {
        eventLimit = atoi(argv[1]);
        if (eventLimit < 0) {
            perror("Invalid event limit. Exiting...\n");
            return 1;
        }
    }

    // Generate filename with current datetime
    string filename = generateFilenameWithDatetime();
    myfile.open(filename.c_str());

    if (!myfile.is_open()) {
        cerr << "Failed to open file: " << filename << endl;
        return 1;
    }
    cout << "File created: " << filename << endl;

    // === Prepend text files ===
    writeFileWithComments("current_adc_settings.txt", myfile);
    writeFileWithComments("last_bitfile_used.txt", myfile);

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

    /* create a UDP socket */
    fd = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
    if (fd < 0) {
        perror("socket creation failed");
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

    /* now loop, receiving data and printing what we received */
    printf("waiting on port %d\n", SERVICE_PORT);
    while (keepRunning) {
        recvlen = recvfrom(fd, reinterpret_cast<char *>(buf), 
                           BUFSIZE, 0, 
                           (struct sockaddr *)&remaddr, &addrlen);

        // Keep collapsing repeated "ff ff ff ff" at packet start.
        while (true) {
            // Need at least 8 bytes to compare two 4-byte words
            if (recvlen < 8) {
                break;
            }

            if(buf[0] == 0xff && buf[1] == 0xff && buf[2] == 0xff && buf[3] == 0xff
               && buf[4] == 0xFF && buf[5] == 0xff && buf[6] == 0xff && buf[7] == 0xff) {
                printf("Found event: FF FF FF FF FF FF FF FF\n");
	    }

            // Check if the first 4 bytes AND the next 4 bytes are all 0xFF
            if (   buf[0] == 0xff && buf[1] == 0xff && buf[2] == 0xff && buf[3] == 0xff
                && buf[4] == 0xff && buf[5] == 0xff && buf[6] == 0xff && buf[7] == 0xff ) {

                // We have "FF FF FF FF FF FF FF FF" at the start -> remove 2nd group
                // Shift the packet up by 4 bytes.
                printf("Removing duplicate FF FF FF FF at start of packet\n");
                memmove(&buf[4], &buf[8], recvlen - 8);
                recvlen -= 4;

            } else {
                // Not a doubled "ff ff ff ff" -> stop collapsing
                break;
            }
        }

        // At this point, if the packet started with multiple consecutive
        // "ff ff ff ff" words, you have compressed them to a single "ff ff ff ff"

        // if the packet is empty / has been emptied after the previous code
        if (recvlen < 8) {
            printf("Skipping packet due to no valid data");
            continue;
        }

        // Get the current position of the put pointer
        streamoff fileSize = myfile.tellp();

        // Convert the size from bytes to megabytes
        double fileSizeInMB = fileSize / 1048576.0;

        counter++;
        buf[recvlen] = 0;

        if (recvlen < 18) {
            perror("Unexpectedly short buffer");
            return 0;
        }

        // start of event word: FF FF FF FF, 00 FF FF FF, [ ... ]
        if(buf[0] == 0xff && buf[1] == 0xff && buf[2] == 0xff && buf[3] == 0xff) {
            event++;
            
            if (eventLimit > 0 && event > eventLimit) {
                printf("Program has reached max number of events (%d), exiting...\n", event - 1);
                break;
            }
            
            subevent = buf[16] & 0xff;


	if (event <= 10) {
	    printf("Event %d\n", event);
	}
	if (event <= 100 && event & 10 == 0) {
	    printf("Event %d\n", event);
	}
	if (event % 1000 == 0) {
	    printf("Event %d\n", event);
	}
            
        // start of subevent word, 00 FF FF FF, [ ... ]
        } else if(buf[0] == 0x00 && buf[1] == 0xff && buf[2] == 0xff && buf[3] == 0xff) {
            subevent = buf[12] & 0xff;
        }

	if (true) {

        printf("%.2x %.2x %.2x %.2x  %.2x %.2x %.2x %.2x [ ... ] "
               "%.2x %.2x %.2x %.2x  %.2x %.2x %.2x %.2x   ",
               buf[0], buf[1], buf[2], buf[3],
               buf[4], buf[5], buf[6], buf[7],
               buf[recvlen-8], buf[recvlen-7], buf[recvlen-6], buf[recvlen-5],
               buf[recvlen-4], buf[recvlen-3], buf[recvlen-2], buf[recvlen-1]);
        printf("[%d] ev.subev: %d.%d (file: %.2f MB)\n", counter, event, subevent,
               fileSizeInMB);
        // printf("%.2x %.2x %.2x %.2x  %.2x %.2x %.2x %.2x  %.2x %.2x %.2x %.2x\n",
        //       buf[8], buf[9], buf[10], buf[11],
        //       buf[12], buf[13], buf[14], buf[15],
        //       buf[16], buf[17], buf[18], buf[19]);
        }


        for (int i=0; i<recvlen; i++){
            myfile << buf[i];
        }
    
    }
    if (myfile.is_open()) {
        myfile.close();
    }

    printf("Program closed after reaching %d events.\n", event - 1);

    return 0;
}
