# Processo para uso do SqlServer

* Referência de desenvolvimento: https://hub.docker.com/_/microsoft-mssql-server

## 1. Inicie o container do sqlserver a partir do docker-compose

* Na pasta databases/sqlserver/$versao execute: 

```shell
docker-compose up -d
```

## 2. Conectando no banco de dados

### Acesse o container mssql-tools:

```shell
docker exec -it sqlserver bash
```

### Conecte no banco de dados via sqlcmd

```shell
/opt/mssql-tools/bin/sqlcmd -S 127.0.0.1 -U sa -P SqlserverDev
```

### Checando funcionamento do banco de dados

1. Ao rodar o sqlcmd acima, deve retornar na próxima linha de comando a seguinte expressão: 1>

2. Após isso, rode o seguinte comando para verificar a versão do database: 

```shell
SELECT @@VERSION

GO
```

3. Deverá retornar com a versão do microsoft sqlserver, a qual é `Microsoft SQL Server 2019 Express Edition`

### Criando acessos e crie o database

1. Crie o usuário para conectar sua aplicação:

```shell
CREATE LOGIN <User> WITH PASSWORD = '<Password>'

GO
```

2. Crie o database

```shell
CREATE DATABASE <Database>

GO
```

## Altere as propriedades do database

1. Altere a propriedades ALLOW_SNAPSHOT_ISOLATION_ON:

```shell
ALTER DATABASE <Database> SET ALLOW_SNAPSHOT_ISOLATION ON

GO
```

2. Altere a propriedade READ_COMMITTED_SNAPSHOT:

```shell
ALTER DATABASE <Database> SET READ_COMMITTED_SNAPSHOT ON

GO
```

## Altere o user criado para db_owner

1. Force o uso do database para o comando no passo 2:

```shell
USE <Database>

GO
```

2. Vincule o login do usuário:

```shell
CREATE USER <User> FOR LOGIN <User>

GO
```

3. Altere as permissões do usuário criado para db_owner:

```shell
ALTER ROLE [db_owner] ADD MEMBER <User>

GO
```