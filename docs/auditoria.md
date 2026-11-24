# Android original · resultados da análise

A coleta com o Android ativo conferiu por SHA-256 os 1.787 arquivos regulares de /system e 21 APKs de /data/app. Também registrou 404 destinos de links simbólicos. Foram examinados o init, scripts de pré-instalação, metadados dos pacotes e código disponível nos APKs/ODEX. A comparação de hashes estabelece a correspondência com o aparelho durante a coleta. A procedência do firmware ainda depende de uma referência independente.

### com.google.ext.am

A cópia instalada e /system/preinstall/com.google.ext.amlogic.apk tinham SHA-256 `ddc35d3ef70a7d61f77e88daa25c36f1434810ad546395e37bff1b93d075b94e`. O pacote compartilhava android.uid.system (UID 1000). O dumpsys enumerava permissões amplas associadas ao UID compartilhado, incluindo instalação de pacotes e alteração de configurações seguras. Essa lista representa capacidade de acesso, mas não prova que o APK tenha usado cada permissão.

Um serviço de pré-instalação executado como root podia reinstalar a cópia de sistema após a perda do marcador em /data. Na coleta, o marcador existia e o pacote estava desabilitado. Um reset de fábrica pode reativar o caminho de pré-instalação.

### com.oranth.deviceinfo

O pacote constava do inventário. O APK de sistema Deviceinfo.apk tinha SHA-256 `ff495d151d4d4b33ca161fdbc5fe0aa559310728dc5ec44f2a627bca6030a97d` e vinha acompanhado de Deviceinfo.odex. A presença justifica a triagem de um componente de fabricante. O material analisado não estabelece roubo de tokens, envio de dados pessoais ou participação em botnet por esse pacote.

### ADB e serviços privilegiados

O Android aceitava uma sessão ADB pela porta TCP 5555 na rede local. Foi observado um shell com prompt de root. A configuração em execução registrava ro.adb.secure=0, ro.debuggable=1, adb_enabled=1 e SELinux em modo Permissive. O build.prop continha ro.adb.secure=0 e service.adb.tcp.port=5555. O firmware estava configurado para dispensar a autorização RSA usual. A coleta não incluiu um segundo cliente sem chaves para testar o comportamento do binário. O serviço sud estava ativo e o serviço activate, iniciado como root, continha um caminho condicional de execução de conteúdo externo sem verificação criptográfica aparente. A auditoria não observou esse caminho sendo acionado.

Esses achados sustentam a decisão de manter o Android em rede isolada. Não houve atribuição confirmada a uma família de malware nem demonstração de persistência em bootloader. A imagem para uso externo é preparada a partir da distribuição CoreELEC. Os backups privados do aparelho permanecem fora da distribuição.
