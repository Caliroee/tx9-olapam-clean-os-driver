KSRC ?=
CROSS_COMPILE ?= aarch64-linux-gnu-
REV := 4d438db955fd93d606e166afe8088b9424b2ed1b

.PHONY: all
all:
	@test -s "$(KSRC)/Module.symvers" || { echo 'Defina KSRC para o kernel compilado com Module.symvers'; exit 1; }
	@test "$$(git -C upstream rev-parse HEAD)" = "$(REV)"
	mkdir -p build
	git -C upstream archive "$(REV):trunk_driver" -o "$(CURDIR)/build/source.tar"
	tar -xf build/source.tar -C build
	sed -i 's/\r$$//' build/os/linux/cfg80211/wf_cfg80211.c
	cd build && patch --binary -p1 < ../tx9-scan.patch
	cmp build/os/linux/cfg80211/wf_cfg80211.c wf_cfg80211.c
	$(MAKE) -C build ARCH=arm64 CROSS_COMPILE="$(CROSS_COMPILE)" KSRC="$(KSRC)" CONFIG_HIF_PORT=sdio
