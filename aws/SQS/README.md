# Testes com o AWS-StepFunctionsLocal

## O que é o Amazon SQS ?

O Amazon Simple Queue Service é um serviço de enfileiramento de mensagens distribuído introduzido pela Amazon.com no final de 2004. Ele suporta o envio programático de mensagens por aplicativos de serviço da Web como uma maneira de se comunicar pela Internet.

* Referência: https://en.wikipedia.org/wiki/Amazon_Simple_Queue_Service

### Uso destinado para testes com sqs, dynamodb entre outros localmente

1. Para inicializar o container do SQS:

```shell
docker-compose up -d
```

2. Para checar o status do serviço, execute o seguinte comando:

```shell
http://localhost:4566/health
``` 

3. Para parar o serviço do SQS:

```shell
docker-compose down
```

### Criando fila no SQS

1. Acesse o container do SQS

```shell
docker exec -it sqs sh
```

2. Configure as credenciais com o seguinte comando:

**IMPORTANTE:** `No comando abaixo onde questionar sobre credenciais (access_key e secret_key), deve-se informar qualquer informação, e na região informe us-east-2`

```shell
aws configure
```

3. Crie a fila desejada

```shell
aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name <queue-name>
```

4. Verifique as listas existentes no SQS local:

```shell
aws --endpoint-url=http://localhost:4566 sqs list-queues
```

### Enviando mensagens para o SQS via aws cli

1. Acesse o container do SQS

```shell
docker exec -it sqs sh
```

2. Ainda em acesso ao container, execute o seguinte comando para enviar uma mensagem:

```shell
aws --endpoint-url=http://localhost:4566 sqs send-message --queue-url http://localhost:4566/000000000000/<queue-name> --message-body 'Aqui vai a mensagem'
```

3. Para ler mensagem por mensagem, execute o comando abaixo:

```shell
aws --endpoint-url=http://localhost:4566 sqs receive-message --queue-url http://localhost:4566/000000000000/<queue-name>
```

### Limpando a lista do SQS

1. Para limpar a lista do SQS, execute o seguinte comando:

```shell
aws --endpoint-url=http://localhost:4566 sqs purge-queue --queue-url http://localhost:4566/000000000000/<queue-name>
```

### Deletando lista do SQS

1. Para deletar a lista, execute o comando abaixo:

```shell
aws --endpoint-url=http://localhost:4566 sqs delete-queue --queue-url http://localhost:4566/000000000000/<queue-name>
```