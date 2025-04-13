obj-m += \
	encx24j600.o \
	encx24j600-regmap.o

all: $(obj-m:.o=.ko) encx24j600-overlay.dtbo

$(obj-m:.o=.ko): $(obj-m:.o=.c)
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean

install: encx24j600-overlay.dtbo
	cp $(obj-m:.o=.ko) /lib/modules/$(shell uname -r)/
	depmod -a
	cp encx24j600-overlay.dtbo /boot/overlays

%.dtbo: %.dts
	dtc -@ -I dts -O dtb -o $@ $<
