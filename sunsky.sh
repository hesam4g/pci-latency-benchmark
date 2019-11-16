#!/bin/bash

./test.sh 0 177d a026 0
mv latency.txt 9th_october_sunsky_arm_cavium_ioreadX_iowriteX_BAR0_NUMANode0.txt
./test.sh 0 177d a026 4
mv latency.txt 9th_october_sunsky_arm_cavium_ioreadX_iowriteX_BAR4_NUMANode0.txt

./test.sh 1 177d a026 0
mv latency.txt 9th_october_sunsky_arm_cavium_readX_writeX_BAR0_NUMANode0.txt
./test.sh 1 177d a026 4
mv latency.txt 9th_october_sunsky_arm_cavium_readX_writeX_BAR4_NUMANode0.txt

