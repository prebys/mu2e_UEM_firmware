# How to start a VNC session

1. Download a VNC client on your local computer. Popular choices are [RealVNC](https://www.realvnc.com/en/) and [TigerVNC](https://tigervnc.org/).
2. SSH into the `mu2euem` computer, and input a command like this: `vncserver :<number> -name <name> -depth 24 -geometry 1920x1080 -localhost -bs`, replacing the `<>` with your own text. The number is a unique identifier for your VNC session and must be unique. <name> can be anything. An example would be:
   - `vncserver :8 -name ryan_vnc -depth 24 -geometry 1920x1080 -localhost -bs`
   - You may need to choose a password for yourself at this step.
3. On your local computer, open a tunnel to the vncserver on the remote computer by entering:
   - `ssh -f -KX -N -L 590<number>:localhost:590<number> mu2euem@mu2euem.dhcp.fnal.gov`
   - Example: `ssh -f -KX -N -L 5908:localhost:5908 mu2euem@mu2euem.dhcp.fnal.gov`
4. Connect to `localhost:590<number>` (example: `localhost:5908`) in your local VNC program.



To see other open VNC connections: `uname -a; ps -efl | grep -i Xvnc | cut -c-120`

(Instructions partially copied from https://mu2ewiki.fnal.gov/wiki/ComputingLogin#Setting_up_a_VNC_client_on_Linux )
