#!/bin/bash


# #NUMA0
# taskset 0x010101010101010101010101 ./test.sh 0 15b3 1003 0
# mv latency.txt 29th_september_helios_x86_mellanox_ioreadX_iowriteX_BAR0_NUMANode0.txt
# taskset 0x010101010101010101010101 ./test.sh 0 15b3 1003 2
# mv latency.txt 29th_september_helios_x86_mellanox_ioreadX_iowriteX_BAR2_NUMANode0.txt
# taskset 0x010101010101010101010101 ./test.sh 1 15b3 1003 0
# mv latency.txt 29th_september_helios_x86_mellanox_readX_writeX_BAR0_NUMANode0.txt
# taskset 0x010101010101010101010101 ./test.sh 1 15b3 1003 2
# mv latency.txt 29th_september_helios_x86_mellanox_readX_writeX_BAR2_NUMANode0.txt

# #NUMA1
# taskset 0x040404040404040404040404 ./test.sh 0 15b3 1003 0
# mv latency.txt 29th_september_helios_x86_mellanox_ioreadX_iowriteX_BAR0_NUMANode1.txt
# taskset 0x040404040404040404040404 ./test.sh 0 15b3 1003 2
# mv latency.txt 29th_september_helios_x86_mellanox_ioreadX_iowriteX_BAR2_NUMANode1.txt
# taskset 0x040404040404040404040404 ./test.sh 1 15b3 1003 0
# mv latency.txt 29th_september_helios_x86_mellanox_readX_writeX_BAR0_NUMANode1.txt
# taskset 0x040404040404040404040404 ./test.sh 1 15b3 1003 2
# mv latency.txt 29th_september_helios_x86_mellanox_readX_writeX_BAR2_NUMANode1.txt

# #NUMA2
# taskset 0x101010101010101010101010 ./test.sh 0 15b3 1003 0
# mv latency.txt 29th_september_helios_x86_mellanox_ioreadX_iowriteX_BAR0_NUMANode2.txt
# taskset 0x101010101010101010101010 ./test.sh 0 15b3 1003 2
# mv latency.txt 29th_september_helios_x86_mellanox_ioreadX_iowriteX_BAR2_NUMANode2.txt
# taskset 0x101010101010101010101010 ./test.sh 1 15b3 1003 0
# mv latency.txt 29th_september_helios_x86_mellanox_readX_writeX_BAR0_NUMANode2.txt
# taskset 0x101010101010101010101010 ./test.sh 1 15b3 1003 2
# mv latency.txt 29th_september_helios_x86_mellanox_readX_writeX_BAR2_NUMANode2.txt

# #NUMA3
# taskset 0x404040404040404040404040 ./test.sh 0 15b3 1003 0
# mv latency.txt 29th_september_helios_x86_mellanox_ioreadX_iowriteX_BAR0_NUMANode3.txt
# taskset 0x404040404040404040404040 ./test.sh 0 15b3 1003 2
# mv latency.txt 29th_september_helios_x86_mellanox_ioreadX_iowriteX_BAR2_NUMANode3.txt
# taskset 0x404040404040404040404040 ./test.sh 1 15b3 1003 0
# mv latency.txt 29th_september_helios_x86_mellanox_readX_writeX_BAR0_NUMANode3.txt
# taskset 0x404040404040404040404040 ./test.sh 1 15b3 1003 2
# mv latency.txt 29th_september_helios_x86_mellanox_readX_writeX_BAR2_NUMANode3.txt

# #NUMA4
# taskset 0x020202020202020202020202 ./test.sh 0 15b3 1003 0
# mv latency.txt 29th_september_helios_x86_mellanox_ioreadX_iowriteX_BAR0_NUMANode4.txt
# taskset 0x020202020202020202020202 ./test.sh 0 15b3 1003 2
# mv latency.txt 29th_september_helios_x86_mellanox_ioreadX_iowriteX_BAR2_NUMANode4.txt
# taskset 0x020202020202020202020202 ./test.sh 1 15b3 1003 0
# mv latency.txt 29th_september_helios_x86_mellanox_readX_writeX_BAR0_NUMANode4.txt
# taskset 0x020202020202020202020202 ./test.sh 1 15b3 1003 2
# mv latency.txt 29th_september_helios_x86_mellanox_readX_writeX_BAR2_NUMANode4.txt

# #NUMA5
# taskset 0x080808080808080808080808 ./test.sh 0 15b3 1003 0
# mv latency.txt 29th_september_helios_x86_mellanox_ioreadX_iowriteX_BAR0_NUMANode5.txt
# taskset 0x080808080808080808080808 ./test.sh 0 15b3 1003 2
# mv latency.txt 29th_september_helios_x86_mellanox_ioreadX_iowriteX_BAR2_NUMANode5.txt
# taskset 0x080808080808080808080808 ./test.sh 1 15b3 1003 0
# mv latency.txt 29th_september_helios_x86_mellanox_readX_writeX_BAR0_NUMANode5.txt
# taskset 0x080808080808080808080808 ./test.sh 1 15b3 1003 2
# mv latency.txt 29th_september_helios_x86_mellanox_readX_writeX_BAR2_NUMANode5.txt


# #NUMA6
# taskset 0x202020202020202020202020 ./test.sh 0 15b3 1003 0
# mv latency.txt 29th_september_helios_x86_mellanox_ioreadX_iowriteX_BAR0_NUMANode6.txt
# taskset 0x202020202020202020202020 ./test.sh 0 15b3 1003 2
# mv latency.txt 29th_september_helios_x86_mellanox_ioreadX_iowriteX_BAR2_NUMANode6.txt
# taskset 0x202020202020202020202020 ./test.sh 1 15b3 1003 0
# mv latency.txt 29th_september_helios_x86_mellanox_readX_writeX_BAR0_NUMANode6.txt
# taskset 0x202020202020202020202020 ./test.sh 1 15b3 1003 2
# mv latency.txt 29th_september_helios_x86_mellanox_readX_writeX_BAR2_NUMANode6.txt


# #NUM7
# taskset 0x808080808080808080808080 ./test.sh 0 15b3 1003 0
# mv latency.txt 29th_september_helios_x86_mellanox_ioreadX_iowriteX_BAR0_NUMANode7.txt
# taskset 0x808080808080808080808080 ./test.sh 0 15b3 1003 2
# mv latency.txt 29th_september_helios_x86_mellanox_ioreadX_iowriteX_BAR2_NUMANode7.txt
# taskset 0x808080808080808080808080 ./test.sh 1 15b3 1003 0
# mv latency.txt 29th_september_helios_x86_mellanox_readX_writeX_BAR0_NUMANode7.txt
# taskset 0x808080808080808080808080 ./test.sh 1 15b3 1003 2
# mv latency.txt 29th_september_helios_x86_mellanox_readX_writeX_BAR2_NUMANode7.txt

#NUMA0
taskset 0x010101010101010101010101 ./test.sh 0 14e4 d802 0
mv latency.txt helios_x86_broadcom_ioreadX_iowriteX_BAR0_NUMANode0.txt
taskset 0x010101010101010101010101 ./test.sh 0 14e4 d802 2
mv latency.txt helios_x86_broadcom_ioreadX_iowriteX_BAR2_NUMANode0.txt
taskset 0x010101010101010101010101 ./test.sh 0 14e4 d802 4
mv latency.txt helios_x86_broadcom_ioreadX_iowriteX_BAR4_NUMANode0.txt

taskset 0x010101010101010101010101 ./test.sh 1 14e4 d802 0
mv latency.txt helios_x86_broadcom_readX_writeX_BAR0_NUMANode0.txt
taskset 0x010101010101010101010101 ./test.sh 1 14e4 d802 2
mv latency.txt helios_x86_broadcom_readX_writeX_BAR2_NUMANode0.txt
taskset 0x010101010101010101010101 ./test.sh 1 14e4 d802 4
mv latency.txt helios_x86_broadcom_readX_writeX_BAR4_NUMANode0.txt


#NUMA1
taskset 0x040404040404040404040404 ./test.sh 0 14e4 d802 0
mv latency.txt helios_x86_broadcom_ioreadX_iowriteX_BAR0_NUMANode1.txt
taskset 0x040404040404040404040404 ./test.sh 0 14e4 d802 2
mv latency.txt helios_x86_broadcom_ioreadX_iowriteX_BAR2_NUMANode1.txt
taskset 0x040404040404040404040404 ./test.sh 0 14e4 d802 4
mv latency.txt helios_x86_broadcom_ioreadX_iowriteX_BAR4_NUMANode1.txt


taskset 0x040404040404040404040404 ./test.sh 1 14e4 d802 0
mv latency.txt helios_x86_broadcom_readX_writeX_BAR0_NUMANode1.txt
taskset 0x040404040404040404040404 ./test.sh 1 14e4 d802 2
mv latency.txt helios_x86_broadcom_readX_writeX_BAR2_NUMANode1.txt
taskset 0x040404040404040404040404 ./test.sh 1 14e4 d802 4
mv latency.txt helios_x86_broadcom_readX_writeX_BAR4_NUMANode1.txt

#NUMA2
taskset 0x101010101010101010101010 ./test.sh 0 14e4 d802 0
mv latency.txt helios_x86_broadcom_ioreadX_iowriteX_BAR0_NUMANode2.txt
taskset 0x101010101010101010101010 ./test.sh 0 14e4 d802 2
mv latency.txt helios_x86_broadcom_ioreadX_iowriteX_BAR2_NUMANode2.txt
taskset 0x101010101010101010101010 ./test.sh 0 14e4 d802 4
mv latency.txt helios_x86_broadcom_ioreadX_iowriteX_BAR4_NUMANode2.txt

taskset 0x101010101010101010101010 ./test.sh 1 14e4 d802 0
mv latency.txt helios_x86_broadcom_readX_writeX_BAR0_NUMANode2.txt
taskset 0x101010101010101010101010 ./test.sh 1 14e4 d802 2
mv latency.txt helios_x86_broadcom_readX_writeX_BAR2_NUMANode2.txt
taskset 0x101010101010101010101010 ./test.sh 1 14e4 d802 4
mv latency.txt helios_x86_broadcom_readX_writeX_BAR4_NUMANode2.txt

#NUMA3
taskset 0x404040404040404040404040 ./test.sh 0 14e4 d802 0
mv latency.txt helios_x86_broadcom_ioreadX_iowriteX_BAR0_NUMANode3.txt
taskset 0x404040404040404040404040 ./test.sh 0 14e4 d802 2
mv latency.txt helios_x86_broadcom_ioreadX_iowriteX_BAR2_NUMANode3.txt
taskset 0x404040404040404040404040 ./test.sh 0 14e4 d802 4
mv latency.txt helios_x86_broadcom_ioreadX_iowriteX_BAR4_NUMANode3.txt

taskset 0x404040404040404040404040 ./test.sh 1 14e4 d802 0
mv latency.txt helios_x86_broadcom_readX_writeX_BAR0_NUMANode3.txt
taskset 0x404040404040404040404040 ./test.sh 1 14e4 d802 2
mv latency.txt helios_x86_broadcom_readX_writeX_BAR2_NUMANode3.txt
taskset 0x404040404040404040404040 ./test.sh 1 14e4 d802 4
mv latency.txt helios_x86_broadcom_readX_writeX_BAR4_NUMANode3.txt

#NUMA4
taskset 0x020202020202020202020202 ./test.sh 0 14e4 d802 0
mv latency.txt helios_x86_broadcom_ioreadX_iowriteX_BAR0_NUMANode4.txt
taskset 0x020202020202020202020202 ./test.sh 0 14e4 d802 2
mv latency.txt helios_x86_broadcom_ioreadX_iowriteX_BAR2_NUMANode4.txt
taskset 0x020202020202020202020202 ./test.sh 0 14e4 d802 4
mv latency.txt helios_x86_broadcom_ioreadX_iowriteX_BAR4_NUMANode4.txt


taskset 0x020202020202020202020202 ./test.sh 1 14e4 d802 0
mv latency.txt helios_x86_broadcom_readX_writeX_BAR0_NUMANode4.txt
taskset 0x020202020202020202020202 ./test.sh 1 14e4 d802 2
mv latency.txt helios_x86_broadcom_readX_writeX_BAR2_NUMANode4.txt
taskset 0x020202020202020202020202 ./test.sh 1 14e4 d802 4
mv latency.txt helios_x86_broadcom_readX_writeX_BAR4_NUMANode4.txt

#NUMA5
taskset 0x080808080808080808080808 ./test.sh 0 14e4 d802 0
mv latency.txt helios_x86_broadcom_ioreadX_iowriteX_BAR0_NUMANode5.txt
taskset 0x080808080808080808080808 ./test.sh 0 14e4 d802 2
mv latency.txt helios_x86_broadcom_ioreadX_iowriteX_BAR2_NUMANode5.txt
taskset 0x080808080808080808080808 ./test.sh 0 14e4 d802 4
mv latency.txt helios_x86_broadcom_ioreadX_iowriteX_BAR4_NUMANode5.txt

taskset 0x080808080808080808080808 ./test.sh 1 14e4 d802 0
mv latency.txt helios_x86_broadcom_readX_writeX_BAR0_NUMANode5.txt
taskset 0x080808080808080808080808 ./test.sh 1 14e4 d802 2
mv latency.txt helios_x86_broadcom_readX_writeX_BAR2_NUMANode5.txt
taskset 0x080808080808080808080808 ./test.sh 1 14e4 d802 4
mv latency.txt helios_x86_broadcom_readX_writeX_BAR4_NUMANode5.txt


#NUMA6
taskset 0x202020202020202020202020 ./test.sh 0 14e4 d802 0
mv latency.txt helios_x86_broadcom_ioreadX_iowriteX_BAR0_NUMANode6.txt
taskset 0x202020202020202020202020 ./test.sh 0 14e4 d802 2
mv latency.txt helios_x86_broadcom_ioreadX_iowriteX_BAR2_NUMANode6.txt
taskset 0x202020202020202020202020 ./test.sh 0 14e4 d802 4
mv latency.txt helios_x86_broadcom_ioreadX_iowriteX_BAR4_NUMANode6.txt

taskset 0x202020202020202020202020 ./test.sh 1 14e4 d802 0
mv latency.txt helios_x86_broadcom_readX_writeX_BAR0_NUMANode6.txt
taskset 0x202020202020202020202020 ./test.sh 1 14e4 d802 2
mv latency.txt helios_x86_broadcom_readX_writeX_BAR2_NUMANode6.txt
taskset 0x202020202020202020202020 ./test.sh 1 14e4 d802 4
mv latency.txt helios_x86_broadcom_readX_writeX_BAR4_NUMANode6.txt


#NUM7
taskset 0x808080808080808080808080 ./test.sh 0 14e4 d802 0
mv latency.txt helios_x86_broadcom_ioreadX_iowriteX_BAR0_NUMANode7.txt
taskset 0x808080808080808080808080 ./test.sh 0 14e4 d802 2
mv latency.txt helios_x86_broadcom_ioreadX_iowriteX_BAR2_NUMANode7.txt
taskset 0x808080808080808080808080 ./test.sh 0 14e4 d802 4
mv latency.txt helios_x86_broadcom_ioreadX_iowriteX_BAR4_NUMANode7.txt

taskset 0x808080808080808080808080 ./test.sh 1 14e4 d802 0
mv latency.txt helios_x86_broadcom_readX_writeX_BAR0_NUMANode7.txt
taskset 0x808080808080808080808080 ./test.sh 1 14e4 d802 2
mv latency.txt helios_x86_broadcom_readX_writeX_BAR2_NUMANode7.txt
taskset 0x808080808080808080808080 ./test.sh 1 14e4 d802 4
mv latency.txt helios_x86_broadcom_readX_writeX_BAR4_NUMANode7.txt