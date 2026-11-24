# Identificação do exemplar

| Item | Evidência e interpretação |
|---|---|
| SoC | Identificação Amlogic GXL, placa p281, CPU ARM 0x41/0xd03 (Cortex-A53), quatro núcleos e DT `gxl_p281_1g`. Conjunto compatível com S905W. A revisão de PCB impressa não foi verificada. |
| RAM | O Android declarava 8.388.608 kB. As faixas de RAM física no mapa do kernel terminavam em 0x3effffff. No boot do CoreELEC, MemTotal foi 1.004.892 kB, coerente com 1 GiB instalado e reservas do sistema. |
| Flash | O controlador MMC identificou DG4008 com 15.273.600 setores de 512 bytes, ou 7,82 GB decimais. |
| Sistema original | Propriedade de versão 11.1, SDK 25 (Android 7.1) e kernel Linux 3.14.29. A discrepância compromete a identificação pelo menu do aparelho. |
| Rádio | SDIO classe 07, fabricante 02E7, dispositivo 9086. O Android carregava 9012p. O log registrou autenticação e associação. A presença da pilha Bluetooth por si só é insuficiente para identificar um controlador físico. |
| Sistema externo | Build oficial Amlogic-ng.arm, ID 8ae70e7c26a5e6ae59ae6a47f5846bd633ac9f56, kernel aarch64 4.9.269. |
