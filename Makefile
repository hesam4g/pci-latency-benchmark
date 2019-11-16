obj-m+=pci-driver.o
MODULE_FILENAME=pci-driver
NODE_NAME="hesam_pci"
KO_FILE=$(MODULE_FILENAME).ko

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
	sudo rmmod $(MODULE_FILENAME)
	sudo rm /dev/$(NODE_NAME)
insert: 
	sudo insmod $(KO_FILE) type_of_operation=$(type_of_operation) ids=$(vendorID):$(deviceID) BAR=$(BAR)
	sudo mknod -m 777 /dev/$(NODE_NAME) c 500 0
