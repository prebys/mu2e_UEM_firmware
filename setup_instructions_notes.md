mar 21, abbreviated startup steps ( referencing steps in Minh's document https://mu2e-docdb.fnal.gov/cgi-bin/sso/ShowDocument?docid=40514 )

1) In one terminal window, open Vivado and program fpga with .bit file, check Minh's document, should be "something something v7.bit"
2) In separate terminal window, open minicom terminal with "`minicomA`" in console
Should have a "$" on the left side of the window. If not, 
that means it couldn't connect. Make sure you programmed 
the FPGA bit file in Vivado

[ below steps are in "code" folder, consider doing "make clean" then "make" ]  
In a third terminal window, run:  

3) `./amc502_mux 192.168.40.02 < mux master.txt`  
4) `./amc502_pll 192.168.40.02 < ZL30162 2x40MHz Dec10 2018.txt`  
5) `./setup_fmc228_begin.sh`  
6) `./setup_fmc228.sh`  
(note, I tried combining above four steps into one "setup.sh" file which could try to be ran, but I haven't tested it well yet)
A bunch of things should pop up in the minicom window each time you run one of the above steps

7) In "socketudp" folder, run "`udp-recv`" file (consider doing "make clean" then "make")  
8) Type "`stream on`" in minicom window, the minicom window   
9) To stop taking data (once you get a file around 20-50 MB), FIRST do "`stream off`" in minicom window, then stop "`udp-recv`" program  

My new directory: 
/root/Documents/mu2e/mu2e_UEM_firmware/
^/code: contains files needed for steps 3-6 above
^/socketudp: contains file needed for step 7


#### DEBUGGING: 

~#####  
~# attempting to send a test signal
from minicom:
$ stream on
$ send 192.168.40.02 48879  -- sends a signal
from terminal:
$ sudo tcpdump -i eth1 udp port 48879 --v -X  -- should receive above signal

~#####  
minicom setup: https://mu2e.fnal.gov/public/workgroups/mu2etest/uTCA_Linux_Setup.html#Minicom_Program

~#####  
192.168.40.2: network box UTC-002
192.168.40.245: FMC-228

~#####  
Signal generator settings:
TTL pulse: 3.3v pulse, around 25 Hz, tiny impulse square wave (0.001% duty cycle)

~#####  
if ./udp-recv fails:
$ sudo iptables -A INPUT -p udp -m udp --dport 48879 -j ACCEPT
to check if it worked,
$ sudo iptables -L INPUT -n | grep 48879
^ should return *something*, if it returns nothing (blank) then iptables didn't work

else, try:
firewall-cmd --permanent --add-port=48879/udp
or:
systemctl stop firewalld  (potentially not recommended)

~#####  
if ever have problem with make, check makefile and see if c compiler is set correctly
try g++ --vers, for example it'll say g++ so go into make file and set g++ instead of gcc
