import sys

print("sys.exectuable in python file", sys.executable)

import sys
import site
print("Executable:", sys.executable)
print("Site-packages:", site.getsitepackages())
print("User-site:", site.getusersitepackages())

import serial
