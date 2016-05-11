/*
 * Device driver for the VGA LED Emulator
 *
 * A Platform device implemented using the misc subsystem
 *
 * Stephen A. Edwards
 * Columbia University
 *
 * References:
 * Linux source: Documentation/driver-model/platform.txt
 *               drivers/misc/arm-charlcd.c
 * http://www.linuxforu.com/tag/linux-device-drivers/
 * http://free-electrons.com/docs/
 *
 * "make" to build
 * insmod top_nn.ko
 *
 * Check code style with
 * checkpatch.pl --file --no-tree top_nn.c
 */

#include <linux/module.h>
#include <linux/init.h>
#include <linux/errno.h>
#include <linux/version.h>
#include <linux/kernel.h>
#include <linux/platform_device.h>
#include <linux/miscdevice.h>
#include <linux/slab.h>
#include <linux/io.h>
#include <linux/of.h>
#include <linux/of_address.h>
#include <linux/fs.h>
#include <linux/uaccess.h>
#include “top_nn.h”

#define DRIVER_NAME "top_nn"

/*
 * Information about our device
 */
struct top_nn_dev {
	struct resource res; /* Resource: our registers */
	void __iomem *virtbase; /* Where registers can be accessed in memory */
} dev;

/*
 * Write segments of a single digit
 * Assumes digit is in range and the device information has been set up
 */
static void write_data(int startaddr, u32 instructions)
{
	iowrite32(instructions, dev.virtbase + startaddr);
}

static unsigned int read_data(int startaddr){
	return ioread32(dev.virtbase+startaddr);
}

/*
 * Handle ioctl() calls from userspace:
 * Read or write the segments on single digits.
 * Note extensive error checking of arguments
 */
static long top_nn_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
{
	top_nn_arg_t tna;

	switch (cmd) {
	case TOP_NN_WRITE_DIGIT:
		if (copy_from_user(&tna, (top_nn_arg_t *) arg,
				   sizeof(top_nn_arg_t)))
			return -EACCES;
		/*if (tna.startaddr > 8)
			return -EINVAL; */
		write_data(tna.startaddr, tna.data);
		u36 instr = (tna.stride << 15);
		instr |= (tna.rows << 7);
		instr |= (tna.bids << 4);
		instr |= tna.options;
               write_data(tna.startaddr, instr);
		u36 instr2 = (tna.aid << 27);
		instr2 |= (tna.block_num << 19);
		instr2 |= (tna.subindex << 3);
		instr2 |= tna.aoptions;
		write_data(tna.startaddr, instr2);
		break;

	case TOP_NN_READ_DIGIT:
		if (copy_from_user(&tna, (top_nn_arg_t *) arg,
				   sizeof(top_nn_arg_t)))
			return -EACCES;
		/*if (tna.digit > 8)
			return -EINVAL;*/
		tna.data = read_data(tna.startaddr);
		if (copy_to_user((top_nn_arg_t *) arg, &tna,
				 sizeof(top_nn_arg_t)))
			return -EACCES;
		break;

	default:
		return -EINVAL;
	}

	return 0;
}

/* The operations our device knows how to do */
static const struct file_operations top_nn_fops = {
	.owner		= THIS_MODULE,
	.unlocked_ioctl = top_nn_ioctl,
};

/* Information about our device for the "misc" framework -- like a char dev */
static struct miscdevice top_nn_misc_device = {
	.minor		= MISC_DYNAMIC_MINOR,
	.name		= DRIVER_NAME,
	.fops		= &top_nn_fops,
};

/*
 * Initialization code: get resources (registers) and display
 * a welcome message
 */
static int __init top_nn_probe(struct platform_device *pdev)
{

	/* Register ourselves as a misc device: creates /dev/top_nn */
	ret = misc_register(&top_nn_misc_device);

	/* Get the address of our registers from the device tree */
	ret = of_address_to_resource(pdev->dev.of_node, 0, &dev.res);
	if (ret) {
		ret = -ENOENT;
		goto out_deregister;
	}

	/* Make sure we can use these registers */
	if (request_mem_region(dev.res.start, resource_size(&dev.res),
			       DRIVER_NAME) == NULL) {
		ret = -EBUSY;
		goto out_deregister;
	}

	/* Arrange access to our registers */
	dev.virtbase = of_iomap(pdev->dev.of_node, 0);
	if (dev.virtbase == NULL) {
		ret = -ENOMEM;
		goto out_release_mem_region;
	}

	/* Load weights here
	for (i = 0; i < top_nn_DIGITS; i++)
		write_digit(i, welcome_message[i]);
        */
	return 0;

out_release_mem_region:
	release_mem_region(dev.res.start, resource_size(&dev.res));
out_deregister:
	misc_deregister(&top_nn_misc_device);
	return ret;
}

/* Clean-up code: release resources */
static int top_nn_remove(struct platform_device *pdev)
{
	iounmap(dev.virtbase);
	release_mem_region(dev.res.start, resource_size(&dev.res));
	misc_deregister(&top_nn_misc_device);
	return 0;
}

/* Which "compatible" string(s) to search for in the Device Tree */
#ifdef CONFIG_OF
static const struct of_device_id top_nn_of_match[] = {
	{ .compatible = "altr,top_nn" },
	{},
};
MODULE_DEVICE_TABLE(of, top_nn_of_match);
#endif

/* Information for registering ourselves as a "platform" driver */
static struct platform_driver top_nn_driver = {
	.driver	= {
		.name	= DRIVER_NAME,
		.owner	= THIS_MODULE,
		.of_match_table = of_match_ptr(top_nn_of_match),
	},
	.remove	= __exit_p(top_nn_remove),
};

/* Called when the module is loaded: set things up */
static int __init top_nn_init(void)
{
	pr_info(DRIVER_NAME ": init\n");
	return platform_driver_probe(&top_nn_driver, top_nn_probe);
}

/* Called when the module is unloaded: release resources */
static void __exit top_nn_exit(void)
{
	platform_driver_unregister(&top_nn_driver);
	pr_info(DRIVER_NAME ": exit\n");
}

module_init(top_nn_init);
module_exit(top_nn_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Stephen A. Edwards, Columbia University");
MODULE_DESCRIPTION("VGA 7-segment LED Emulator");
