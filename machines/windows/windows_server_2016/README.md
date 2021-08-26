# Provisionando VM com Windows Server 2016

- IMPORTANTE: Sempre executar no windows 10 no gitbash com privilegios administrativos.

## Antes de tudo, instale o vagrant:

[Vagrant Download](https://www.vagrantup.com/downloads)

### Após instalado o Vagrant, instale o seguinte plugin:

```shell
vagrant plugin install vagrant-timezone
```

## Lista de Provedores disponíveis

- Virtual Box (virtualbox)
- Hyper-V (hyperv)

## Provisionando Windows Server

Executar o comando abaixo para provisionar a vm desejada:

```shell
vagrant up --provider <provider>
```

### Exemplos

Exemplo do comando acima com provisionamento com hyperv:

```shell
vagrant up --provider hyperv
```

Exemplo do comando acima com provisionamento com virtualbox:

```shell
vagrant up --provider virtualbox
```

## Destruindo máquinas virtuais Windows Server

Executar o comando abaixo:

```shell
vagrant destroy -f
```
