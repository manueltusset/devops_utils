# Portainer

## O que é?

O Portainer permite configuração, gerenciamento e segurança centralizados de ambientes Kubernetes e Docker, permitindo que você entregue 'Containers-as-a-Service' para seus usuários de forma rápida, fácil e segura.

## Rodando e utilizando

- Antes de tudo, é importante que realize a criação do volume do portainer:

```shell
docker volume create portainer_data
```

- Para rodar o portainer deve-se rodar o seguinte comando:

```shell
docker-compose up -d
```

- Para utilizar a interface para gerenciamento, pode-se utilizar o seguinte link:

```shell
http://localhost:8000/
```

- Após acessado o link acima, deve-se inserir uma senha para administrar os seus containers.
