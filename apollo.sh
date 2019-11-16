#!/bin/bash

#NUMA0

./test.sh 0 15b3 1003 0
mv latency.txt 30th_september_apollo_x86_mellanox_ioreadX_iowriteX_BAR0_NUMANode0.txt
./test.sh 0 15b3 1003 2
mv latency.txt 30th_september_apollo_x86_mellanox_ioreadX_iowriteX_BAR2_NUMANode0.txt
./test.sh 1 15b3 1003 0
mv latency.txt 30th_september_apollo_x86_mellanox_readX_writeX_BAR0_NUMANode0.txt
./test.sh 1 15b3 1003 2
mv latency.txt 30th_september_apollo_x86_mellanox_readX_writeX_BAR2_NUMANode0.txt


./test.sh 0 14e4 d802 0
mv latency.txt 30th_september_apollo_x86_broadcom_ioreadX_iowriteX_BAR0_NUMANode0.txt
./test.sh 0 14e4 d802 2
mv latency.txt 30th_september_apollo_x86_broadcom_ioreadX_iowriteX_BAR2_NUMANode0.txt
./test.sh 0 14e4 d802 4
mv latency.txt 30th_september_apollo_x86_broadcom_ioreadX_iowriteX_BAR4_NUMANode0.txt

./test.sh 1 14e4 d802 0
mv latency.txt 30th_september_apollo_x86_broadcom_readX_writeX_BAR0_NUMANode0.txt
./test.sh 1 14e4 d802 2
mv latency.txt 30th_september_apollo_x86_broadcom_readX_writeX_BAR2_NUMANode0.txt
./test.sh 1 14e4 d802 4
mv latency.txt 30th_september_apollo_x86_broadcom_readX_writeX_BAR4_NUMANode0.txt
