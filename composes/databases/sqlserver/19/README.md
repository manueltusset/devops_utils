# Processo para uso do sqlserver 19

## 1. Inicie o container do sqlserver a partir do docker-compose

* Na pasta composes/databases/sqlserver/19 execute: 

`docker-compose up -d`

## 2. Inspecione o container sqlserver19 para capturar o IP do mesmo

* No prompt de comando execute o seguinte script para inspecionar o container do pg12:

`docker inspect sqlserver19`

* Após inspecionado o container, copie o valor da key **IPAddress**:

`"IPAddress": "x.x.x.x"`

## 3. Conectando no banco de dados

### Acesse o container mssql-tools:

`docker exec -it mssql-tools bash`

### Conecte no banco de dados via sqlcmd

* **Importante salientar que deve substituir o parametro {IP} pelo ip copiado no passo 2.**

`sqlcmd -S {IP} -U sa -P Sqlserver19`

### Checando funcionamento do banco de dados

1. Ao rodar o sqlcmd acima, deve retornar na próxima linha de comando a seguinte expressão: 1>

2. Após isso, rode o seguinte comando: `SELECT @@VERSION`

3. Rodado o comando acima, rode o comando: `GO`

4. Deverá retornar com a versão do microsoft sqlserver, a qual é `Microsoft SQL Server 2019 Express Edition`