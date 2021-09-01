# Provisionamento de Máquinas Virtuais com Vagrant

## Preparando ambiente

1. Baixe o [Vagrant](https://www.vagrantup.com/downloads)
2. Instale o mesmo seguindo as etapas do instalador.
3. Instale o plugin abaixo via gitbash para setar corretamente o timezone:
```shell
vagrant plugin install vagrant-timezone
```
4. Instale o plugin abaixo via gitbash para realizar o subscription-manager caso usar o redhat:
```shell
vagrant plugin install vagrant-registration
```

## Provisionamento

### Para provisionar as máquinas viruais, execute o comando abaixo:

1. Para host windows:
```shell
.\vagrant.ps1 up
```
2. Para host linux:
```shell
.\vagrant.sh up
```

## SSH

### Para acessar as máquinas virtuais linux via ssh, execute o comando abaixo:

1. Para host windows:
```shell
.\vagrant.ps1 ssh
```
2. Para host linux:
```shell
.\vagrant.sh ssh
```

## Destruir

### Para destruir máquinas virtuais linux via ssh, execute o comando abaixo:

1. Para host windows:
```shell
.\vagrant.ps1 destroy
```
2. Para host linux:
```shell
.\vagrant.sh destroy
```