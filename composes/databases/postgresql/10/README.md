## Processo para uso do postgresql 10

### 1. Inicie o container do postgres e pgadmin a partir do docker-compose

* Na pasta composes/databases/postgresql/10 execute: 

`docker-compose up -d`

### 2. Inspecione o container postgresql10 para capturar o IP do mesmo

* No prompt de comando execute o seguinte script para inspecionar o container do pg10:

`docker inspect postgresql10`

* Após inspecionado o container, copie o valor **IPAddress**:

`"IPAddress": "x.x.x.x"`

### 3. Acesse o pgAdmin 4 via browser

* Com o link http://localhost:55432 acesse o pgAdmin 4 para cadastrar um novo server:

`Na tela Welcome do pgAdmin 4, clique em "Add New Server"`

* Preenchendo as informações para cadastro na aba General:

`Name: Server`

* Preenchendo as informações para cadastro na aba Connection:

`Host: Informe o ip que foi copiado ao inspecionar o container do postgresql10 no passo 2`

`Port: 5432`

`Maintenance database: postgres`

`Username: postgres`

`Password: postgres`

* Para salvar a conexão, basta clicar em save

### 4. Processo de criação de database

* Criando login

1. `Ao lado esquerdo, dentro do server cadastrado, cloque com o botão direito em "Login/Group Roles" > "Create" > "Login/Group Role".`

2. `Na aba General, informe o nome do mesmo.`

3. `Na aba Definition, informe a senha do mesmo.`

4. `Na aba Privileges, selecione Can login? e Superuser?, assim o restante das opções serão selecionadas.`

5. `Na aba Membership, nos 2 campos informe o grupo postgres.`

