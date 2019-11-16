#!/bin/bash

#	Sonme examples:
#					TYPE 	VID 		DID 		REGIO	
#	./test.sh		1		0x10ec		0x5227		0		tests Hesam's laptop 
#	./test.sh		1		0x15b3		0x1003		2		tests Hesam's PC at Stevens (Mellanox)
#	./test.sh 		1		0xXXXX		0xYYYY		2
#
#	If the first argument is 0, the module uses ioreads/iowrites functions, 
#	on the other hand, it uses readb, readw, readl, readq, writeb, writew, wrtitel and writeq

echo $1 $2 $3 $4
MAX_SIZE=12
NUMBER_OF_ITERATION=999

rm latency.txt
touch latency.txt

echo "R/RW/W" >> latency.txt

# rm write_latency.txt
# touch write_latency.txt



# Here we check whether another module for Mellanox is loaded or not!
./init.sh

for i in $(seq 0 $MAX_SIZE)
do
	SIZE=$((2 ** $i))
	var="#define BYTE_NUMBER		$SIZE"
	sed -i "1s/.*/$var/" pci-driver.c
	sudo dmesg -C
	make 
	make insert type_of_operation=$1 vendorID=$2 deviceID=$3 BAR=$4
	for j in $(seq 0 $NUMBER_OF_ITERATION)
	do
		cat /dev/hesam_pci
	done


	echo -n $SIZE >> latency.txt
	echo -n -e "\t\t\t\t\t" >> latency.txt

	avg_read=$(dmesg | cut -b 15- | awk '{if ($1 == "READ_TIME")
				{
					READ_SUM+=$2
					counter++
				}
				}
				END{print READ_SUM/counter}')

	
	echo -n -e $avg_read >> latency.txt
	echo -n -e "\t\t\t\t\t" >> latency.txt



	sudo dmesg -C
	for j in $(seq 0 $NUMBER_OF_ITERATION)
	do
		echo salam > /dev/hesam_pci
	done

	avg_RW=$(dmesg | cut -b 15- | awk '{if ($1 == "READ_WRITE_TIME")
				{
					WR_SUM+=$2
					counter++
				}
				}
				END{print WR_SUM/counter}')

	avg_write=$(dmesg | cut -b 15- | awk '{if ($1 == "WRITE_TIME")
				{
					WRITE_SUM+=$2
					counter++
				}
				}
				END{print WRITE_SUM/counter}')

	echo -n -e $avg_RW >> latency.txt
	echo -n -e "\t\t\t\t\t" >> latency.txt
	echo -n -e $avg_write >> latency.txt
	echo -e "\t\t\t\t\t" >> latency.txt


	make clean
done


cat latency.txt
