# Processo para uso do postgresql 10

* Referência de desenvolvimento: https://hub.docker.com/_/postgres

## 1. Inicie o container do postgres e pgadmin a partir do docker-compose

* Na pasta composes/databases/postgresql/10 execute: 

`docker-compose up -d`

## 2. Inspecione o container postgresql10 para capturar o IP do mesmo

* No prompt de comando execute o seguinte script para inspecionar o container do pg10:

`docker inspect postgresql10`

* Após inspecionado o container, copie o valor da key **IPAddress**:

`"IPAddress": "x.x.x.x"`

## 3. Acesse o pgAdmin 4 via browser

### Com o link http://localhost:55432 acesse o pgAdmin 4 para cadastrar um novo server:

1. Na tela **Welcome** do pgAdmin 4, clique em **Add New Server**

### Preenchendo as informações para cadastro na aba General:

1. Name: Server

### Preenchendo as informações para cadastro na aba Connection:

1. Host: Informe o ip que foi copiado ao inspecionar o container do postgresql10 no passo 2

2. Port: 5432

3. Maintenance database: postgres

4. Username: postgres

5. Password: postgres

6. Feito isso, clique em save.

## 4. Processo de criação de database

### Criando login

1. Na coluna esquerda, dentro do server cadastrado, cloque com o botão direito em "Login/Group Roles" > "Create" > "Login/Group Role".

2. Na aba General, informe o nome do mesmo.

3. Na aba Definition, informe a senha do mesmo.

4. Na aba Privileges, selecione Can login? e Superuser?, assim o restante das opções serão selecionadas.

5. Na aba Membership, nos 2 campos informe o grupo postgres.

### Criando TABLESPACES_DATA

1. Na pasta composes/databases/postgresql/10/data/pgdata, crie a pasta TABLESPACES_DATA

2. No pgAdmin 4, na coluna esquerda, clique com o botão direito em "Tablespaces" > "Create" > "Tablespace...".

3. Na aba General, informe o nome da tablespace, a qual será chamada de TABLESPACES_DATA.

4. Na aba General, informe também o Owner, que será o usuário criado no passo 4

5. Na aba definition, informe o caminho /var/lib/postgresql/data/pgdata/TABLESPACES_DATA no campo Location, porém sem as aspas.

6. Feito isso, clique em save.

### Criando TABLESPACES_INDEXES

1. Na pasta composes/databases/postgresql/10/data/pgdata, crie a pasta TABLESPACES_INDEXES

2. No pgAdmin 4, na coluna esquerda, clique com o botão direito em "Tablespaces" > "Create" > "Tablespace...".

3. Na aba General, informe o nome da tablespace, a qual será chamada de TABLESPACES_INDEXES.

4. Na aba General, informe também o Owner, que será o usuário criado no passo 4

5. Na aba definition, informe o caminho /var/lib/postgresql/data/pgdata/TABLESPACES_INDEXES no campo Location, porém sem as aspas.

6. Feito isso, clique em save.

### Criando Database

1. Na coluna esquerda, clique com o botão direito em "Databases" > "Create" > "Database...".

2. Na aba General, informe o nome do database no campo "Database".

3. Ainda na aba General, informe o usuário criado no campo "Owner".

4. Na aba Definition, informe no campo "Tablespace" a TABLESPACES_DATA criada anteriormente.

5. Feito isso, clique em save.