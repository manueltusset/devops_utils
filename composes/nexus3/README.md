# Usando Nexus 3

## Inicialização

1. Antes de tudo, crie o volume do nexus em sua máquina host:
```shell
docker volume create --name nexus-data
```

2. Após isso, inicialize o container:
```shell
docker-compose up -d
```

## Realizando acesso

1. Para realizar o primeiro acesso, deve-se abrir o seguinte link:

```shell
http://localhost:8081/
```

2. Após acessado o link acima, deve-se obter a credencial do usuário admin:
```shell
docker exec -it nexus3 bash

cat /nexus-data/admin.password
```

3. Copie a credencial acima resultante do comando `cat` e realize o login com usuário admin.