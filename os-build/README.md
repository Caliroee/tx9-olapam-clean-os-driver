# Preparar a imagem e iniciar pelo USB

Base utilizada: CoreELEC-Amlogic-ng.arm-21.3-Omega-Generic.img.gz. O script exige o SHA-256 registrado na coleta da imagem de distribuição. O DTB incluído foi extraído da imagem preparada para o exemplar e comparado byte a byte com device_trees/gxl_p281_1g.dtb da imagem genérica. kernel.config veio do kernel em execução e serve à compilação do módulo. [Distribuição oficial](https://github.com/CoreELEC/CoreELEC/releases/tag/21.3-Omega)

Em Linux com Bash, gzip, coreutils e mtools, execute a partir da raiz, indicando um diretório de saída novo:

```sh
bash os-build/prepare.sh CoreELEC-Amlogic-ng.arm-21.3-Omega-Generic.img.gz release/v0.1-experimental
(cd release/v0.1-experimental && sha256sum -c SHA256SUMS)
```

Crie antes a pasta pai com `mkdir -p release`. O script trabalha sobre uma cópia temporária da imagem oficial e instala o DTB na raiz da primeira partição FAT. A imagem resultante inicia com Ethernet. O teste do módulo Wi-Fi é uma etapa manual descrita no guia do driver.

1. Descompacte o .img.gz. No Rufus, selecione a imagem .img e confira a capacidade e a identificação do pendrive. A gravação apaga o conteúdo da unidade selecionada. Use o modo de escrita de imagem bruta (DD) se o programa oferecer essa escolha.
2. Com o TX9 desligado, conecte o pendrive. No exemplar avaliado, o primeiro boot externo foi acionado por `adb reboot update` a partir do computador, com o Android em rede isolada e a sessão ADB já autorizada.
3. No primeiro boot, aguarde a preparação da partição de dados e o assistente. Confira o modelo de DT, a saída HDMI, o áudio e a rede por cabo. Habilite SSH só quando necessário e defina uma senha própria.
4. Para retornar ao sistema anterior, desligue pelo menu, retire a mídia e mantenha o aparelho isolado das redes que o Android conheça. O boot externo preserva a eMMC. A gravação interna e a recuperação de um bootloader danificado ficaram fora da validação.

A pasta release/ é local e ignorada pelo Git. O .img.gz e SHA256SUMS podem ser anexados juntos a uma GitHub Release experimental. A imagem recém-preparada foi verificada por leitura do DTB. O teste físico foi feito com a imagem anterior preparada a partir da mesma base.
