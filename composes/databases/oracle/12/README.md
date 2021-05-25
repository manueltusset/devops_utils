## Processo para uso do oracle12

* Referência de desenvolvimento: https://medium.com/@firzhan/installing-oracle-12c-as-a-docker-container-44985b29bcae

### 1. Inicie o container do oracle a partir do docker-compose

* Na pasta composes/databases/oracle/12 execute: 

`docker-compose -d up`

### 2. Acesse o container para realizar os comandos necessários para a primeira configuração

* No prompt de comando execute o seguinte script para acessar o container do oracle12c:

`docker exec -it oracle12 bash -c "source /home/oracle/.bashrc; sqlplus /nolog"`

* Após acessado o container, estará acessando o sqlplus, rode o comando abaixo para conectar os usuários:

`connect sys as sysdba;`

* Altere a sessão do oracle:

`alter session set “_ORACLE_SCRIPT”=true;`

* Para criar uma table space data, execute o script seguinte substituindo o parâmetro {base} pelo nome da base de dados (importante salientar para criar em maiúsculo as nomenclaturas)

`CREATE TABLESPACE TSD_{base} LOGGING DATAFILE '/ORCL/TABLESPACES/TSD_{base}.DBF' SIZE 2000M AUTOEXTEND ON NEXT 200M MAXSIZE UNLIMITED;`

* Para criar uma table space indexes, execute o script seguinte substituindo o parâmetro {base} pelo nome da base de dados (importante salientar para criar em maiúsculo as nomenclaturas)

`CREATE TABLESPACE TSI_{base} LOGGING DATAFILE '/ORCL/TABLESPACES/TSI_{base}.DBF' SIZE 200M AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED;`

* Para criar o usuário de acesso para os table space e table indexes criados, execute o comando abaixo substituindo o parâmetro {user} , {senha} e {base}:

`CREATE USER {user} IDENTIFIED BY {pass} DEFAULT TABLESPACE TSI_{base} QUOTA UNLIMITED ON TSD_{base} QUOTA UNLIMITED ON TSI_{base};`

* Após criado o usuário e tablespaces, precisamos garantir acesso para correto funcionamento:

`GRANT CREATE SESSION TO {base};`

`GRANT CREATE PROCEDURE TO {base};`

`GRANT CREATE VIEW TO {base};`

`GRANT CREATE TABLE TO {base};`

`GRANT CREATE SEQUENCE TO {base};`

`GRANT CREATE TRIGGER TO {base};`

# 3. Conexão no Oracle SQL Developer

* Name: {base}

* Username: {user}

* Password: {pass}

* Hostname: localhost

* Port: 1521

* Service Name: ORCLCDB.localdomain