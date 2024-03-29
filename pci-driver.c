#define BYTE_NUMBER		4
/***************************************************************************
 *   Copyright (C) 2005 by trem                                            *
 *   tremyfr@yahoo.fr                                                      *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
 ***************************************************************************/

/**
 * This program is an example of a simple pci driver.
 * 
 * This is a driver for a VIRTUAL card which can simply send and receive bytes.
 *
 * There are only 3 registers:
 * STATUS: addr = BAR2 + 0
 *	unused for now
 * READ_DATA: addr = BAR2 + 1
 *	this register can only be read. Each time it's read, the device
 *	reads a byte from its input and returns it.
 * WRITE_DATA: addr = BAR2 + 2
 *	this register can only be written. Each time it's written, the device
 *	writes the byte on its output.
 * 
 */

#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/pci.h>
#include <linux/fs.h>
#include <linux/cdev.h>		/* for cdev_ */
#include <asm/uaccess.h>        /* for put_user */
#include <linux/moduleparam.h>


#define MAX_DEVICE		8
#define DEVICE_NAME 		"virtual_pci"
#define BAR_IO			2
#define BAR_MEM			2


MODULE_DESCRIPTION("A PCIE driver to measure latencies.");
MODULE_AUTHOR("hesam4g");
MODULE_LICENSE("GPL");

/*
*		This parameter shows which type of read/write functions should be used!
* 		When:
			type_of_operation = 0	 --->	ioread8/iowrite8
											ioread16/iowrite16
											ioread32/iowrite32

			type_of_operation = 1	 --->	readb/writeb
											readw/writew
											readl/wrotel
											readq/wroteq
*/
static 	int type_of_operation = 1;
module_param(type_of_operation, int, 0);


/*
	This is an array to get device and vendor ID
*/
static char ids[1024] __initdata;
module_param_string(ids, ids, sizeof(ids), 0);

static int BAR;
module_param(BAR, int, 0);


static dev_t devno;
static int major;

/**
 *  This structure is used to link a pci_dev to a cdev 
 *
 */
struct pci_cdev {
	int minor;
	struct pci_dev *pci_dev;
	struct cdev *cdev;
};

static struct pci_cdev pci_cdev[MAX_DEVICE];

/* this function initialize the table with all struct pci_cdev */
static void pci_cdev_init(struct pci_cdev pci_cdev[], int size, int first_minor)
{
	int i;

	for(i=0; i<size; i++) {
		pci_cdev[i].minor   = first_minor++;
		pci_cdev[i].pci_dev = NULL;
		pci_cdev[i].cdev    = NULL;
	}
}

/*
	-1 	=> failed
	 others => succes
*/
static int pci_cdev_add(struct pci_cdev pci_cdev[], int size, struct pci_dev *pdev)
{
	int i, res = -1;

	for(i=0; i<size; i++) {
		if (pci_cdev[i].pci_dev == NULL) {
			pci_cdev[i].pci_dev = pdev;
			res = pci_cdev[i].minor;
			break;
		}
	}
	
	return res;
}

static void pci_cdev_del(struct pci_cdev pci_cdev[], int size, struct pci_dev *pdev)
{
	int i;

	for(i=0; i<size; i++) {
		if (pci_cdev[i].pci_dev == pdev) {
			pci_cdev[i].pci_dev = NULL;
		}
	}
}

static struct pci_dev *pci_cdev_search_pci_dev(struct pci_cdev pci_cdev[], int size, int minor)
{
	int i;
	struct pci_dev *pdev = NULL;

	for(i=0; i<size; i++) {
		if (pci_cdev[i].minor == minor) {
			pdev = pci_cdev[i].pci_dev;
			break;
		}
	}

	return pdev;	
}

static struct cdev *pci_cdev_search_cdev(struct pci_cdev pci_cdev[], int size, int minor)
{
	int i;
	struct cdev *cdev = NULL;

	for(i=0; i<size; i++) {
		if (pci_cdev[i].minor == minor) {
			cdev = pci_cdev[i].cdev;
			break;
		}
	}

	return cdev;	
}

/* 
 	-1 	=> not found
	others	=> found
*/
static int pci_cdev_search_minor(struct pci_cdev pci_cdev[], 
		int size, struct pci_dev *pdev)
{
	int i, minor = -1;

	for(i=0; i<size; i++) {
		if (pci_cdev[i].pci_dev == pdev) {
			minor = pci_cdev[i].minor;
			break;
		}
	}

	return minor;
}



/**
 * This function is called when the device node is opened
 *
 */
static int pci_open(struct inode *inode, struct file *file)
{
	int minor = iminor(inode);
	file->private_data = (void *)pci_cdev_search_pci_dev(pci_cdev, MAX_DEVICE, minor);
	return 0;
}

/**
 * This function is called when the device node is closed
 *
 */
static int pci_release(struct inode *inode, struct file *file)
{
	return 0;
}

/**
 * This function is called when the device node is read
 *
 */
static ssize_t pci_read(struct file *file,	/* see include/linux/fs.h   */
			   char *buffer,	/* buffer to fill with data */
			   size_t length,	/* length of the buffer     */
			   loff_t * offset)
{ 
	int i;
	u64 value_64;
	u32 value_32;
	u16 value_16;
	u8 	value_8;
	ktime_t t1;
	ktime_t t2;
	void __iomem *pci_io_addr;
	unsigned long flags;
	

	/********************************** READING PROCESS BEGINS HERE **********************************/

	struct pci_dev *pdev = (struct pci_dev *)file->private_data;
	pci_io_addr = pci_ioremap_bar(pdev, BAR);
//	printk(KERN_ALERT "pci_io_addr:     %ld", pci_io_addr);

	i 	=	BYTE_NUMBER;
	preempt_disable();
	raw_local_irq_save(flags);
	t1 = ktime_get();
	if(type_of_operation)
	{
		for (i=BYTE_NUMBER; i>=8; i-=8)
		{
			value_64 = readq(pci_io_addr + BYTE_NUMBER - i);
		}
		if (i/4)
		{
			value_32 = readl(pci_io_addr + BYTE_NUMBER - i);
			i-=4;
		}
		if (i/2)
		{
			value_16 = readw(pci_io_addr + BYTE_NUMBER - i);
			i-=2;
		}
		if (i==1)
			value_8 = readb(pci_io_addr + BYTE_NUMBER - i);
	}
	else
	{
		for (i=BYTE_NUMBER; i>=4; i-=4)
		{
			value_32 = ioread32(pci_io_addr + BYTE_NUMBER - i);
		}
		if(i/2)
		{
			value_16 = ioread16(pci_io_addr + BYTE_NUMBER - i);
			i-=2;
		}
		if(i==1)
			value_8 = ioread8(pci_io_addr + BYTE_NUMBER - i);
	}
	
	t2 = ktime_get();
	raw_local_irq_restore(flags);
	preempt_enable();
	printk(KERN_ALERT "type_of_operation:     %d", type_of_operation);
	printk(KERN_ALERT "READ_TIME %lld" , t2 - t1);

	/*********************************** READING PROCESS ENDS HERE ***********************************/

	return 0;
}

/**
 * This function is called when the device node is read
 *
 */
static ssize_t pci_write(struct file *file,
						const char *buffer,
						size_t len, loff_t * off)
{
	/*********************************** WRITING PROCESS BEGINS HERE ***********************************/
	/************************************** READ/WRITE ***********************************/

	int i;
	u64 value_64;
	u32 value_32;
	u16 value_16;
	u8 	value_8;
	ktime_t t1;
	ktime_t t2;
	void __iomem *pci_io_addr;
	unsigned long flags;

	struct pci_dev *pdev = (struct pci_dev *)file->private_data;
	value_64 = 100;
	value_32 = 100;
	value_16 = 100;
	value_8 = 100;


	pci_io_addr = pci_ioremap_bar(pdev, BAR);
	i 	=	BYTE_NUMBER;
	preempt_disable();
	raw_local_irq_save(flags);
	t1 = ktime_get();
	if(type_of_operation)
	{
		for (i=BYTE_NUMBER; i>=8; i-=8)
		{
			writeq(i, pci_io_addr + BYTE_NUMBER - i);
			value_64 = readq(pci_io_addr + BYTE_NUMBER - i);

		}
		if (i/4)
		{
			writel(i, pci_io_addr + BYTE_NUMBER - i);
			value_32 = readl(pci_io_addr + BYTE_NUMBER - i);
			i-=4;
		}
		if (i/2)
		{
			writew(i, pci_io_addr + BYTE_NUMBER - i);
			value_16 = readl(pci_io_addr + BYTE_NUMBER - i);
			i-=2;
		}
		if (i==1)
			{
				writeb(i, pci_io_addr + BYTE_NUMBER - i);
				value_8 = readb(pci_io_addr + BYTE_NUMBER - i);
			}
	}
	else
	{
		for (i=BYTE_NUMBER; i>=4; i-=4)
		{
			iowrite32(i, pci_io_addr + BYTE_NUMBER - i);
			value_32 = ioread32(pci_io_addr + BYTE_NUMBER - i);
		}
		if(i/2)
		{
			iowrite16(i, pci_io_addr + BYTE_NUMBER - i);
			value_16 = ioread16(pci_io_addr + BYTE_NUMBER - i);
			i-=2;
		}
		if(i==1)
		{
			iowrite8(i, pci_io_addr + BYTE_NUMBER - i);
			value_8 = ioread8(pci_io_addr + BYTE_NUMBER - i);
		}
	}

	t2 = ktime_get();
	raw_local_irq_restore(flags);
	preempt_enable();
	printk(KERN_ALERT "READ_WRITE_TIME %lld" , t2 - t1);


	/************************************** WRITE ONLY ***********************************/
	pci_io_addr = pci_ioremap_bar(pdev, BAR);
	i 	=	BYTE_NUMBER;
	preempt_disable();
	raw_local_irq_save(flags);
	t1 = ktime_get();
	if(type_of_operation)
	{
		for (i=BYTE_NUMBER; i>=8; i-=8)
		{
			writeq(i, pci_io_addr + BYTE_NUMBER - i);
		}
		if (i/4)
		{
			writel(i, pci_io_addr + BYTE_NUMBER - i);
			i-=4;
		}
		if (i/2)
		{
			writew(i, pci_io_addr + BYTE_NUMBER - i);
			i-=2;
		}
		if (i==1)
			{
				writeb(i, pci_io_addr + BYTE_NUMBER - i);
			}
	}
	else
	{
		for (i=BYTE_NUMBER; i>=4; i-=4)
		{
			iowrite32(i, pci_io_addr + BYTE_NUMBER - i);
		}
		if(i/2)
		{
			iowrite16(i, pci_io_addr + BYTE_NUMBER - i);
			i-=2;
		}
		if(i==1)
		{
			iowrite8(i, pci_io_addr + BYTE_NUMBER - i);
		}
	}

	t2 = ktime_get();
	raw_local_irq_restore(flags);
	preempt_enable();
	printk(KERN_ALERT "WRITE_TIME %lld" , t2 - t1);

	/*********************************** WRITING PROCESS ENDS HERE ***********************************/
	return len;
}

/**
 * This structure holds informations about the pci node
 *
 */
static struct file_operations pci_ops = {
	.owner		= THIS_MODULE,
	.read 		= pci_read,
	.write 		= pci_write,
	.open 		= pci_open,
	.release 	= pci_release
};


/**
 * This function is called when a new pci device is associated with a driver
 *
 * return: 0 => this driver don't handle this device
 *         1 => this driver handle this device
 *
 */
static int pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
{
	int ret, minor;
	struct cdev *cdev;
	dev_t devno;

	/* add this pci device in pci_cdev */
	if ((minor = pci_cdev_add(pci_cdev, MAX_DEVICE, dev)) < 0)
		goto error;

	/* compute major/minor number */
	devno = MKDEV(major, minor);

	/* allocate struct cdev */
	cdev = cdev_alloc();

	/* initialise struct cdev */
	cdev_init(cdev, &pci_ops);
	cdev->owner = THIS_MODULE;

	/* register cdev */
	ret = cdev_add(cdev, devno, 1);
	if (ret < 0) {
		dev_err(&(dev->dev), "Can't register character device\n");
		goto error;
	}
	pci_cdev[minor].cdev = cdev;

	dev_info(&(dev->dev), "%s The major device number is %d (%d).\n",
	       "Registeration is a success", MAJOR(devno), MINOR(devno));
	dev_info(&(dev->dev), "If you want to talk to the device driver,\n");
	dev_info(&(dev->dev), "you'll have to create a device file. \n");
	dev_info(&(dev->dev), "We suggest you use:\n");
	dev_info(&(dev->dev), "mknod %s c %d %d\n", DEVICE_NAME, MAJOR(devno), MINOR(devno));
	dev_info(&(dev->dev), "The device file name is important, because\n");
	dev_info(&(dev->dev), "the ioctl program assumes that's the\n");
	dev_info(&(dev->dev), "file you'll use.\n");

	/* enable the device */
	pci_enable_device(dev);

	/* 'alloc' IO to talk with the card */
	// if (pci_request_region(dev, BAR_IO, "IO-pci") == 0) {
	// 	dev_err(&(dev->dev), "Can't request BAR2\n");
	// 	cdev_del(cdev);
	// 	goto error;
	// }

	//  check that BAR_IO is *really* IO region 
	// if ((pci_resource_flags(dev, BAR_IO) & IORESOURCE_IO) != IORESOURCE_IO) {
	// 	dev_err(&(dev->dev), "BAR2 isn't an IO region\n");
	// 	cdev_del(cdev);
	// 	goto error;
	// }

	return 0;

error:
	return 1;
}

/**
 * This function is called when the driver is removed
 *
 */
static void pci_remove(struct pci_dev *dev)
{
	int minor;
	struct cdev *cdev;

	/* remove associated cdev */
	minor = pci_cdev_search_minor(pci_cdev, MAX_DEVICE, dev);
	cdev = pci_cdev_search_cdev(pci_cdev, MAX_DEVICE, minor);
	if (cdev != NULL) 
		cdev_del(cdev);
		
	/* remove this device from pci_cdev */
	pci_cdev_del(pci_cdev, MAX_DEVICE, dev);

	/* release the IO region */
	pci_release_region(dev, BAR_IO);
}

/**
 * This structure holds informations about the pci driver
 *
 */
static struct pci_driver pci_driver = {
	.name 		= "pci",
	.id_table 	= NULL,
	.probe 		= pci_probe,
	.remove 	= pci_remove,
};


/**
 * This function is called when the module is loaded
 *
 */
static int __init pci_init_module(void)
{
	int ret, err;
	char *p, *id;

	printk(KERN_DEBUG "Module pci init\n");
	/* allocate (several) major number */

	// ret = alloc_chrdev_region(&devno, 0, MAX_DEVICE, "buffer");

	devno = MKDEV(500, 0);
	ret = register_chrdev_region(devno, MAX_DEVICE, "buffer");
	
	if (ret < 0) {
		printk(KERN_ERR "Can't get major\n");
		return ret;
	}

	/* get major number and save it in major */
	major = MAJOR(devno);

	/* initialise pci_cdev */
	pci_cdev_init(pci_cdev, MAX_DEVICE, MINOR(devno));

	/* register pci driver */
	ret = pci_register_driver(&pci_driver);
	if (ret < 0) {
		/* free major/minor number */
		unregister_chrdev_region(devno, 1);

		printk(KERN_ERR "pci-driver: can't register pci driver\n");
		return ret;
	}

	/* add ids specified in the module parameter */
	p = ids;
	while ((id = strsep(&p, ","))) {
		unsigned int vendor, device, subvendor = PCI_ANY_ID,
			subdevice = PCI_ANY_ID, class=0, class_mask=0;
		int fields;

		if (!strlen(id))
			continue;

		fields = sscanf(id, "%x:%x:%x:%x:%x:%x",
				&vendor, &device, &subvendor, &subdevice,
				&class, &class_mask);

		if (fields < 2) {
			// pr_warn(DRIVER_NAME ": invalid id string \"%s\"\n", id);
			continue;
		}

		// pr_info(DRIVER_NAME ": add %04X:%04X sub=%04X:%04X cls=%08X/%08X\n",
			// vendor, device, subvendor, subdevice, class, class_mask);

		err = pci_add_dynid(&pci_driver, vendor, device, subvendor, subdevice, class, class_mask, 0);
		if (err)
			printk(KERN_ALERT "failed to add dynamic id (%d)\n", err);
	}

	return 0;
}

/**
 * This function is called when the module is unloaded
 *
 */
static void pci_exit_module(void)
{
	int i;

	/* unregister pci driver */
	pci_unregister_driver(&pci_driver);

	/* unregister character device */
	for(i=0; i< MAX_DEVICE; i++) {
		if (pci_cdev[i].pci_dev != NULL) {
			cdev_del(pci_cdev[i].cdev);
		}
	}

	/* free major/minor number */
	unregister_chrdev_region(devno, MAX_DEVICE);

	printk(KERN_DEBUG "Module pci exit\n");
}

module_init(pci_init_module);
module_exit(pci_exit_module);
