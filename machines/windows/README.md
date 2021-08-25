# Provisionando máquinas virtuais Windows

- IMPORTANTE: Sempre executar no windows 10 no gitbash com privilegios administrativos.

## Lista de Versões disposíveis

- Windows Server 2016 (Versão: 2016)
- Windows Server 2019 (Versão: 2019)

## Lista de Provedores disponíveis

- Virtual Box (virtualbox)
- Hyper-V (hyperv)

## Windows Server

Executar o comando abaixo para provisionar a vm desejada:

```shell
Tag=<tag> Branch=<branch> Version=<version> vagrant up --provider <provider>
```

Exemplo do comandoa cima:

```shell
Tag=2.1.6.5 Branch=2-1-6 Version=2019 vagrant up --provider hyperv
```
