Raspberry Pi ENCX24J600 driver 
=====================================

This project implements a simple suite of kernel modules and a device tree
overlay to enable the Raspberry Pi ENC424J600 10/100 ethernet chip.

The driver was made by combining .c .h from the kernel source code

https://github.com/torvalds/linux/tree/v6.14/drivers/net/ethernet/microchip

and a modified dts file from the Linux for raspberry pi

https://github.com/raspberrypi/linux/blob/rpi-6.12.y/arch/arm/boot/dts/overlays/enc28j60-overlay.dts

and a modified makefile from

https://github.com/jhol/rpi-raw-i2s-io/blob/master/Makefile

Tested on RPI 4 with rpi-6.12.y


Connections
-----------

RPI

3v3 		  >> vcc
GPIO 10 (MOSI)    >> SI
GPIO 9 (MISO)     >> SO
GPIO 11 (SCLK)    >> CLK
GPIO 25 (INT)     >> INT
GPIO 8 (CS)       >> CS
GND 	          >> GND

Installation
-----------

1. Install prerequisites:

    ```
     $ sudo apt install make gcc linux-headers device-tree-compiler
    ```

2. Build the modules and overlay:

    ```
     $ make
    ```

3. Install the modules and overlay:

    ```
     $ sudo make install
    ```
    
4. Check if it was properly installed:

    ```
     $ ls /boot/overlays/encx24*
    ```
    
    The RPI should return:
    
     ```
      $ /boot/overlays/encx24j600-overlay.dtbo
     ```

4. Enable device tree overlay.

    Open the boot configuration file in a text editor:

    ```
     $ sudo editor /boot/firmware/config.txt
    ```

    Find the line that has `dtparam=spi=on`. Enable it by removing the `#` in front.

    Then add `dtoverlay=encx24j600-overlay` on the next line.


5. Reboot:

    ```
     $ sudo reboot -h now
    ```

6. Check if the ethernet car was registered:

    ```
     $ ifconfig
    ```





Fadi Jerji 04/2025
