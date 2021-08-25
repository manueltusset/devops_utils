# Provisionando máquinas virtuais Windows

- IMPORTANTE: Sempre executar no windows 10 no gitbash com privilegios administrativos.

## Antes de tudo, instale o vagrant:

[Vagrant Download](https://www.vagrantup.com/downloads)

### Após instalado o Vagrant, instale o seguinte plugin:

```shell
vagrant plugin install vagrant-timezone
```

## Lista de Versões disposíveis

- Windows Server 2016 (Versão: 2016)
- Windows Server 2019 (Versão: 2019)

## Lista de Provedores disponíveis

- Virtual Box (virtualbox)
- Hyper-V (hyperv)

## Provisionando Windows Server

Executar o comando abaixo para provisionar a vm desejada:

```shell
Tag=<tag> Branch=<branch> Version=<version> vagrant up --provider <provider>
```

### Exemplos

Exemplo para windows server 2016 do comando acima:

```shell
Tag=2.1.6.5 Branch=2-1-6 Version=2016 vagrant up --provider hyperv
```

Exemplo para windows server 2019 do comando acima:

```shell
Tag=2.1.6.5 Branch=2-1-6 Version=2019 vagrant up --provider hyperv
```

## Destruindo máquinas virtuais Windows Server

Executar o comando abaixo:

```shell
Version=<version> vagrant destroy -f
```

### Exemplos

Exemplo para windows server 2016 do comando acima:

```shell
Version=2016 vagrant destroy -f
```

Exemplo para windows server 2019 do comando acima:

```shell
Version=2019 vagrant destroy -f
```
