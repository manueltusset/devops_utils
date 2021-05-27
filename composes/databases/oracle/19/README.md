## Processo para uso do oracle19

* Referência de desenvolvimento: https://www.oracle.com/br/technical-resources/articles/database-performance/oracle-db19c-com-docker.html

### 1. Inicie o container do oracle a partir do docker-compose

* Na pasta composes/databases/oracle/18 execute: 

`docker-compose up -d`

### 2. Acesse o container para realizar os comandos necessários para a primeira configuração

* No prompt de comando execute o seguinte script para acessar o container do oracle19c:

`docker exec -it oracle19 bash -c "source /home/oracle/.bashrc; sqlplus /nolog"`

* Após acessado o container, estará acessando o sqlplus, rode o comando abaixo para conectar os usuários:

`conn / as sysdba;`

* Altere a sessão do oracle:

`alter session set "_ORACLE_SCRIPT"=true;`

* Para criar uma table space data, execute o script seguinte substituindo o parâmetro SESUITE19C pelo nome da base de dados (importante salientar para criar em maiúsculo as nomenclaturas)

`CREATE TABLESPACE TSD_SESUITE19C LOGGING DATAFILE '/opt/oracle/oradata/TSD_SESUITE19C.DBF' SIZE 2000M AUTOEXTEND ON NEXT 200M MAXSIZE UNLIMITED;`

* Para criar uma table space indexes, execute o script seguinte substituindo o parâmetro SESUITE19C pelo nome da base de dados (importante salientar para criar em maiúsculo as nomenclaturas)

`CREATE TABLESPACE TSI_SESUITE19C LOGGING DATAFILE '/opt/oracle/oradata/TSI_SESUITE19C.DBF' SIZE 200M AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED;`

* Para criar o usuário de acesso para os table space e table indexes criados, execute o comando abaixo substituindo o parâmetro SESUITE19C , 111111 e SESUITE19C:

`CREATE USER SESUITE19C IDENTIFIED BY 111111 DEFAULT TABLESPACE TSI_SESUITE19C QUOTA UNLIMITED ON TSD_SESUITE19C QUOTA UNLIMITED ON TSI_SESUITE19C;`

* Após criado o usuário e tablespaces, precisamos garantir acesso para correto funcionamento:

`GRANT CREATE SESSION TO SESUITE19C;`

`GRANT CREATE PROCEDURE TO SESUITE19C;`

`GRANT CREATE VIEW TO SESUITE19C;`

`GRANT CREATE TABLE TO SESUITE19C;`

`GRANT CREATE SEQUENCE TO SESUITE19C;`

`GRANT CREATE TRIGGER TO SESUITE19C;`

### 3. Conexão no Oracle SQL Developer

* Name: SESUITE19C

* Username: SESUITE19C

* Password: 111111

* Hostname: localhost

* Port: 1521

* SID: orclpdb1

### 4. Acessando o database home oracle

* https://localhost:5500/em/shell 