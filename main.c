#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/fs.h>
#include <linux/uaccess.h>

#define DEVICE_NAME "my_char_device"
#define CLASS_NAME "my_char_class"

static int majorNumber;
static struct class* myCharClass = NULL;
static struct device* myCharDevice = NULL;

static int dev_open(struct inode *inodep, struct file *filep) {
    printk(KERN_INFO "dev %s opened\n", DEVICE_NAME);
    return 0;
}

static int dev_release(struct inode *inodep, struct file *filep) {
    printk(KERN_INFO "dev %s closed\n", DEVICE_NAME);
    return 0;
}

static ssize_t dev_read(struct file *filep, char *buffer, size_t len, loff_t *offset) {
    printk(KERN_INFO "dev %s read\n", DEVICE_NAME);
    return 0;
}

static ssize_t dev_write(struct file *filep, const char *buffer, size_t len, loff_t *offset) {
    printk(KERN_INFO "dev recv: %s\n", message);
    return 0;
}

static struct file_operations fops = {
    .open = dev_open,
    .read = dev_read,
    .write = dev_write,
    .release = dev_release,
};

static int __init my_char_init(void) {
    printk(KERN_INFO "init%s\n", DEVICE_NAME);

    majorNumber = register_chrdev(0, DEVICE_NAME, &fops);
    myCharClass = class_create(THIS_MODULE, CLASS_NAME);
    myCharDevice = device_create(myCharClass, NULL, MKDEV(majorNumber, 0), NULL, DEVICE_NAME);
    printk(KERN_INFO "%s created %d\n", DEVICE_NAME, majorNumber);
    return 0;
}

static void __exit my_char_exit(void) {
    device_destroy(myCharClass, MKDEV(majorNumber, 0));
    class_unregister(myCharClass);
    class_destroy(myCharClass);
    unregister_chrdev(majorNumber, DEVICE_NAME);
    printk(KERN_INFO "dev %s deleted\n", DEVICE_NAME);
}

module_init(my_char_init);
module_exit(my_char_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("name");
MODULE_DESCRIPTION("chardev");
MODULE_VERSION("0.1");