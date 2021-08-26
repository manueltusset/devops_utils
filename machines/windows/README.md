# Provisionando Máquinas Virtuais Windows

- IMPORTANE: Os comandos abaixo devem ser executados em gitbash com privilégios administrativos.

## Provedores disponíveis

- hyperv
- virtualbox

## Versões disponíveis

- 2016
- 2019

## Provisionamento

- Para provisionar máquinas virtuais linux com as versões e provedores acima, deve-se executar o seguinte comando:

```shell
VERSION=<version> vagrant up --provider <provider>
```

- Exemplo

```shell
VERSION=2016 vagrant up --provider hyperv
```

## Destruir

- Para destruir as máquinas virtuais provisionadas com as versões e provedores acima, deve-se execcutar o seguinte comando:

```shell
VERSION=<version> vagrant destroy -f
```

- Exemplo

```shell
VERSION=2016 vagrant destroy -f
```
