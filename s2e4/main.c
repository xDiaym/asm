#include <stdio.h>
#include <stdlib.h>
#include <libusb-1.0/libusb.h>

void print_device_info(libusb_device *device) {
    struct libusb_device_descriptor desc;
    int r = libusb_get_device_descriptor(device, &desc);
    if (r < 0) {
        fprintf(stderr, "Failed to get device descriptorn");
        return;
    }

    printf("Device Descriptor:\n");
    printf("  Vendor ID: %04x\n", desc.idVendor);
    printf("  Product ID: %04x\n", desc.idProduct);
    printf("  Device Class: %02x\n", desc.bDeviceClass);
    printf("  Device Subclass: %02x\n", desc.bDeviceSubClass);
    printf("  Device Protocol: %02x\n", desc.bDeviceProtocol);
    printf("  Max Packet Size: %d\n", desc.bMaxPacketSize0);
    printf("  Device Version: %02x.%02x\n", desc.bcdUSB >> 8, desc.bcdUSB & 0xff);
    printf("  Manufacturer: %d\n", desc.iManufacturer);
    printf("  Product: %d\n", desc.iProduct);
    printf("  Serial Number: %d\n", desc.iSerialNumber);
    printf("  Number of Configurations: %d\n", desc.bNumConfigurations);
}

int main() {
    libusb_context *ctx = NULL;
    libusb_device **devs;
    ssize_t cnt;

    // Initialize libusb
    if (libusb_init(&ctx) < 0) {
        fprintf(stderr, "Failed to initialize libusbn");
        return EXIT_FAILURE;
    }

    // Get list of USB devices
    cnt = libusb_get_device_list(ctx, &devs);
    if (cnt < 0) {
        fprintf(stderr, "Failed to get device listn");
        libusb_exit(ctx);
        return EXIT_FAILURE;
    }

    // Iterate through the devices and print their info
    for (ssize_t i = 0; i < cnt; i++) {
        print_device_info(devs[i]);
        printf("\n");
    }

    // Free the device list
    libusb_free_device_list(devs, 1);

    // Exit libusb
    libusb_exit(ctx);
    return EXIT_SUCCESS;
}
