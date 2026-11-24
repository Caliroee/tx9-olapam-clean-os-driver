# TX9 OLAPAM · CoreELEC externo e Wi-Fi SDIO

> **Driver de rede experimental.** O módulo encontrou redes, associou-se a um ponto de acesso e transportou pacotes. Durante o uso, o kernel emitiu avisos repetidos no caminho SDIO e o Kodi caiu uma vez. A validação está em fase inicial. Teste por USB ou SD em rede isolada, por sua conta e risco. O procedimento testado usou USB.

> **Hardware whitelabel específico.** Projeto para o TV Box TX9 da marca **OLAPAM**, com Amlogic S905W, placa `gxl_p281_1g`, 1 GB de RAM real, eMMC DG4008 e Wi-Fi SDIO `02E7:9086`. “TX9” é um nome comercial usado por diversos fabricantes, inclusive em placas incompatíveis. Até a conclusão desta auditoria, o projeto nunca encontrou outro exemplar OLAPAM com essa combinação documentado publicamente. A compatibilidade com outros TX9 permanece desconhecida.

**Autoria do projeto e da adaptação: caliroe.** O TX9 inicializou o CoreELEC 21.3-Omega oficial a partir de um pendrive de 8 GB. A preparação da imagem seleciona o Device Tree da placa. O trabalho de compilação local abrangeu o kernel para obter os símbolos de versão e o módulo Wi-Fi para teste em memória. A imagem preparada usa o kernel e o sistema de arquivos distribuídos pelo CoreELEC.

| Função | Resultado neste exemplar |
|---|---|
| Boot externo | Assistente inicial concluído. O Android continuou disponível na memória interna. |
| HDMI e áudio | Reprodução a 1080p60 com áudio confirmada pelo operador. |
| Ethernet | DHCP e sessão SSH funcionais. |
| Wi-Fi | Após a correção, 6 redes na busca normal e 8 pontos de acesso na passiva. Associação e 6 respostas a 6 pings enviados pela interface sem fio ao roteador. |
| Estabilidade | Um encerramento do Kodi com SIGSEGV e avisos em `aml_sd_emmc_pre_dma` na recepção SDIO. A relação causal entre os eventos permanece aberta. |
| Internet e Bluetooth | O operador relatou associação ao hotspot. Reprodução contínua pela internet e funcionamento do Bluetooth ficaram sem validação. |

## Como usar

1. Compare os identificadores de hardware com o [relatório da placa](docs/hardware.md) e o [mapa da eMMC](docs/particoes.md).
2. Siga o [guia da imagem e do boot USB](os-build/README.md). Use Ethernet para a primeira configuração. A imagem inicia sem carregar o módulo experimental.
3. Para desenvolver ou testar o rádio, obtenha o repositório com `git clone --recurse-submodules` e siga o [guia do driver](driver/README.md).
4. Consulte a [análise do Android original](docs/auditoria.md) antes de voltar a inicializá-lo. O boot externo permite usar o Kodi e preserva o Android para recuperação ou perícia.

O projeto disponibiliza as contribuições de caliroe sob a GPL-2.0-or-later. Os créditos e as licenças originais do CoreELEC, do kernel e do driver SmartChip continuam aplicáveis aos respectivos componentes. [Licença](LICENSE) · [CoreELEC 21.3-Omega](https://github.com/CoreELEC/CoreELEC/releases/tag/21.3-Omega)
