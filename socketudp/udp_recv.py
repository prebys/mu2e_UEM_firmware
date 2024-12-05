import socket
import netifaces
import sys

def udp_packet_receiver(interface='eth1', bufsize=4096, use_raw=False):
    try:
        if use_raw:
            # Create a raw socket to capture all UDP packets
            sock = socket.socket(socket.AF_PACKET, socket.SOCK_RAW, socket.ntohs(0x0800))
            sock.bind((interface, 0))
            print(f"Listening on interface {interface} for all packets...")
        else:
            # Get the IP address of the specified interface
            ip = netifaces.ifaddresses(interface)[netifaces.AF_INET][0]['addr']
            print(f"IP address of interface {interface}: {ip}")

            # Create a socket for UDP
            sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM, socket.IPPROTO_UDP)
            sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
            sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)  # Enable broadcast reception

            # Bind the socket to the specific IP address and port 48879
            sock.bind((ip, 48879))
            print(f"Listening on IP {ip} (interface {interface}) for UDP packets on port 48879...")

        counter = 0
        while True:
            packet, addr = sock.recvfrom(bufsize)
            if use_raw:
                # Extract the IP header from the packet (first 20 bytes)
                ip_header = packet[14:34]
                protocol = ip_header[9]

                # Check if the packet is a UDP packet
                if protocol == 17:  # 17 is the protocol number for UDP
                    print(f"[{counter}] Received UDP packet: {len(packet)} bytes from {addr}")
                    counter += 1
            else:
                print(f"[{counter}] Received packet from {addr}: {len(packet)} bytes")
                counter += 1
    except KeyboardInterrupt:
        print("Program interrupted.")
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        if 'sock' in locals():
            sock.close()
            print("Socket closed.")

if __name__ == "__main__":
    use_raw = len(sys.argv) > 1 and sys.argv[1].lower() == 'raw'
    # You can set the buffer size and interface here as well if you want different values
    udp_packet_receiver(interface='eth1', bufsize=9000, use_raw=use_raw)

