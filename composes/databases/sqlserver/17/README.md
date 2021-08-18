# Processo para uso do sqlserver 17

* Referência de desenvolvimento: https://hub.docker.com/_/microsoft-mssql-server

## 1. Inicie o container do sqlserver a partir do docker-compose

* Na pasta composes/databases/sqlserver/17 execute: 

```shell
docker-compose up -d
```

## 2. Inspecione o container sqlserver17 para capturar o IP do mesmo

* No prompt de comando execute o seguinte script para inspecionar o container do pg12:

```shell
docker inspect sqlserver17
```

* Após inspecionado o container, copie o valor da key **IPAddress**:

`"IPAddress": "x.x.x.x"`

## 3. Conectando no banco de dados

### Acesse o container mssql-tools:

```shell
docker exec -it mssql-tools bash
```

### Conecte no banco de dados via sqlcmd

* **Importante salientar que deve substituir o parametro {IP} pelo ip copiado no passo 2.**

```shell
sqlcmd -S {IP} -U sa -P Sqlserver17
```

### Checando funcionamento do banco de dados

1. Ao rodar o sqlcmd acima, deve retornar na próxima linha de comando a seguinte expressão: 1>

2. Após isso, rode o seguinte comando para verificar a versão do database: 

```shell
SELECT @@VERSION;

GO;
```

3. Deverá retornar com a versão do microsoft sqlserver, a qual é `Microsoft SQL Server 2017 Express Edition`

### Criando acessos e crie o database

1. Crie o usuário para conectar sua aplicação:

```shell
CREATE LOGIN <User> WITH PASSWORD = '<Password>';

GO;
```

2. Crie o database

```shell
CREATE DATABASE <Database>;

GO;
```

## Altere as propriedades do database

1. Altere a propriedades ALLOW_SNAPSHOT_ISOLATION_ON:

```shell
ALTER DATABASE <Database> SET ALLOW_SNAPSHOT_ISOLATION ON;

GO;
```

2. Altere a propriedade READ_COMMITTED_SNAPSHOT:

```shell
ALTER DATABASE <Database> SET READ_COMMITTED_SNAPSHOT ON;

GO;
```

## Altere o user criado para db_owner

1. Force o uso do database para o comando no passo 2:

```shell
USE <Database>;

GO;
```

2. Vincule o login do usuário:

```shell
CREATE USER <User> FOR LOGIN <User>;

GO;
```

3. Force o uso do database para o comando no passo 4: 
```shell
USE <Database>;

GO;
```

4. Altere as permissões do usuário criado para db_owner:

```shell
ALTER ROLE [db_owner] ADD MEMBER <User>;

GO;
```