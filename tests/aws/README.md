# Testes com o AWS-StepFunctionsLocal

### Uso destinado para testes com sqs, dynamodb entre outros localmente

1. Para inicializar o container para os testes:

```shell
docker-compose --env-file=aws-stepfunctions-local-credentials.txt up -d
```

2. Para parar o container:

```shell
docker-compose --env-file=aws-stepfunctions-local-credentials.txt down
```