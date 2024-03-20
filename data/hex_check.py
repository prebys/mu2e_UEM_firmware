#!/usr/bin python3

import sys

def main():
	if len(sys.argv) != 2:
		print("Usage: `python3 hex_check.py path_to_data_file.dat`")
		return

	input_file = sys.argv[1]

	# open binary file
	with open(input_file, "rb") as file:
		binary_data = file.read()  # a "bytes" object

	# convert to hex, should be a string starting with "ffffffffffffff00" etc
	hex_data = binary_data.hex()
	
	print(hex_data)

if __name__ == "__main__":
	main()	
	
