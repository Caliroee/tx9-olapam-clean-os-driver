# Compilar e testar o 9012p

O submódulo upstream fixa o código completo em 4d438db955fd93d606e166afe8088b9424b2ed1b. A unidade modificada está em wf_cfg80211.c e a diferença em tx9-scan.patch. O driver público reconhece o mesmo dispositivo SDIO que o módulo Android v14.3.24_15589.201907251330. A identidade exata entre os fontes permanece desconhecida.

O callback de varredura lia o primeiro SSID antes de verificar se a lista existia. A correção verifica a presença e o tamanho do SSID antes de identificar Wi-Fi Direct, valida a requisição antes de acessar seus canais e encaminha buscas sem SSIDs ao modo passivo. A falha anterior em varredura passiva deixou de ocorrer no reteste. Os avisos posteriores durante recepção SDIO continuam em investigação.

Em Linux ou WSL2, use um sistema de arquivos Linux para compilar. No Ubuntu 24.04, instale git, make, gcc, gcc-aarch64-linux-gnu, binutils-aarch64-linux-gnu, bc, bison, flex, libssl-dev, libelf-dev, kmod e patch. A partir da raiz do projeto:

```sh
git submodule update --init driver/upstream
git clone https://github.com/CoreELEC/linux-amlogic.git kernel-tx9
git -C kernel-tx9 checkout --detach 50c8e8154c5aba3c7cd8438d04dd5fdd51733e41
cp os-build/kernel.config kernel-tx9/.config
export ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
make -C kernel-tx9 olddefconfig
make -C kernel-tx9 -j"$(nproc)" vmlinux
make -C driver KSRC="$(pwd)/kernel-tx9"
modinfo -F vermagic driver/build/s9083s.ko
modprobe --show-modversions ./driver/build/s9083s.ko | grep module_layout
```

Valores do teste: `4.9.269 SMP preempt mod_unload modversions aarch64` e CRC `0x19e145ad` para module_layout. Se o kernel ou os símbolos divergirem, recompile contra a árvore correta. O firmware usado pelo módulo já existia no CoreELEC como ram-fw-908x-old-r1549.bin.

Para o teste, mantenha Ethernet conectada em rede isolada e use o IP do **CoreELEC**. A cópia usa o modo SCP clássico suportado pela unidade.

```sh
scp -O driver/build/s9083s.ko root@IP_DO_TX9:/tmp/
ssh root@IP_DO_TX9
uname -r
insmod /tmp/s9083s.ko
connmanctl scan wifi
iw dev wlan0 link
```

Selecione a rede no painel de conexões do CoreELEC. Confirme tráfego com `ping -I wlan0 -c 6 IP_DO_ROTEADOR` e examine `dmesg`. No exemplar estudado, os avisos de DMA incluíram sdio_irq_handle no módulo e aml_sd_emmc_pre_dma no controlador. Encerre o teste caso os avisos voltem. Reiniciar pelo menu descarrega o módulo. O projeto não habilita autoload.
