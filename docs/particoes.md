# eMMC do exemplar OLAPAM

Nomes de /dev/block e tamanhos de /proc/partitions no Android em execução. A coluna KiB usa blocos de 1.024 bytes. Os números identificam os dispositivos observados nesta unidade.

| mmcblk0p | Nome | KiB |
|---:|---|---:|
| 1 | bootloader | 4096 |
| 2 | reserved | 65536 |
| 3 | cache | 524288 |
| 4 | env | 8192 |
| 5 | logo | 32768 |
| 6 | recovery | 32768 |
| 7 | rsv | 8192 |
| 8 | tee | 8192 |
| 9 | crypt | 32768 |
| 10 | misc | 32768 |
| 11 | boot | 32768 |
| 12 | system | 2097152 |
| 13 | data | 4634432 |

O Android expunha o DTB por /dev/dtb e apresentava ainda boot0, boot1 e RPMB com 4.096 KiB cada. A fstab montava system como ext4 somente leitura, além de data e cache em ext4. Nenhuma partição vendor separada apareceu nesse mapa. Os números servem para identificação. A instalação descrita neste projeto grava somente mídia externa.
