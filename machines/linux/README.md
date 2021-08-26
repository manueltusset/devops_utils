# Provisionando Máquinas Virtuais Linux

- IMPORTANE: Os comandos abaixo devem ser executados em gitbash com privilégios administrativos.

## Provedores disponíveis

- hyperv
- virtualbox

## Boxes disponíveis

- generic/centos7
- generic/centos8
- generic/debian8
- generic/rhel7
- generic/rhel8
- generic/ubuntu1804
- generic/ubuntu2004

## Provisionamento

- Para provisionar máquinas virtuais linux com as boxes e provedores acima, deve-se executar o seguinte comando:

```shell
BOX=<box> NAME=<name> vagrant up --provider <provider>
```

- Exemplo

```shell
BOX=generic/rhel7 NAME=redhat7.9 vagrant up --provider hyperv
```

## Destruir

- Para destruir as máquinas virtuais provisionadas com as boxes e provedores acima, deve-se execcutar o seguinte comando:

```shell
BOX=<box> NAME=<name> vagrant destroy -f
```

- Exemplo

```shell
BOX=generic/rhel7 NAME=redhat7.9 vagrant destroy -f
```
