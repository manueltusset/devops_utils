# Provisionando Máquinas Virtuais Linux

- IMPORTANE: Os comandos abaixo devem ser executados em gitbash com privilégios administrativos.

## Provedores disponíveis

- hyperv
- virtualbox

## Boxes disponíveis

- generic/centos7
- generic/debian8
- generic/rhel7
- generic/rhel8
- generic/ubuntu1804
- generic/ubuntu2004

## Provisionamento

- Para provisionar máquinas virtuais linux com as boxes e provedores acima, deve-se executar o seguinte comando:

```shell
vagrant up --provider <provider>
```

- Exemplo

```shell
vagrant up --provider hyperv
```

## Conectando via ssh

```shell
vagrant ssh
```

## Destruir

- Para destruir as máquinas virtuais provisionadas com as boxes e provedores acima, deve-se execcutar o seguinte comando:

```shell
vagrant destroy -f
```
