#!/usr/bin/python

from os import system as terminal
from os import popen as popen

NUMBER_OF_ITERATIO = 100
POWER_OF_TWO = 5


def change_file_byte_number(BYTE_NUMBER):
	terminal("sed -i \"1s/.*/#define BYTE_NUMBER		"+str(BYTE_NUMBER)+"/\" pci-driver.c")
	return


def find_in_dmesg(looking_key, a):
	index = 0
	looking_key = str(looking_key)
	output_list = []
	for x in a:
		x = x.strip().split()
		try:
			index = x.index(looking_key)
			# print(x[index + 1])
			output_list.append(int(x[index + 1]))
		except:
			pass
	return output_list


average_read = []

average_write = []
for i in range(POWER_OF_TWO):
	terminal("sudo dmesg -C")
	change_file_byte_number(2**i)
	terminal("make")
	terminal("make insert")
	for i in range(NUMBER_OF_ITERATIO):
		terminal("cat /dev/hesam_pci")
		terminal("echo salam > /dev/hesam_pci")
	terminal("make clean")

	a  = popen('dmesg').readlines()



	read = find_in_dmesg("READ_TIME",a)
	average_read.append(sum(read) / len(read))

	write = find_in_dmesg("WRITE_TIME",a)
	average_write.append(sum(write) / len(write))



print(average_read)
print(average_write)
