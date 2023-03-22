## Procedimento Oracle

1. Acesse o container do oracle.
```shell
docker exec -it oracle bash
```

2. Caso queira realizar um restore de um pdb, realize o download do dump no seguinte diretório: `/opt/oracle/restore`

3. Crie a pasta container (caso não exista):
```shell
mkdir -p /opt/oracle/oradata/container
```

4. Conecte no sqlplus:
```shell
sqlplus / as sysdba;
```

5. Altere arquivo de destino:
```sql
ALTER SYSTEM SET db_create_file_dest = '/opt/oracle/oradata/container';
```

6. Crie o pdb:
```sql
CREATE PLUGGABLE DATABASE {PDB_NAME} ADMIN USER {PDB_NAME} IDENTIFIED BY {PDB_USERADMIN_PASS};
```

7. Abra o pdb para receber conexões:
```sql
ALTER PLUGGABLE DATABASE {PDB_NAME} OPEN;
```

8. Saia do sqlplus:
```sql
exit
```

9. Conecte no sqlplus no pdb criado com o usuário system:
```shell
sqlplus system/{PASS_SYSTEM}@127.0.0.1/{PDB_NAME};
```

10. Crie a tablespace data:
```sql
CREATE TABLESPACE {TABLESPACE_DATA_NAME} LOGGING DATAFILE '/opt/oracle/oradata/{TABLESPACE_DATA_NAME}.dbf' SIZE 10M AUTOEXTEND ON NEXT 10M EXTENT MANAGEMENT LOCAL;
```

11. Crie a tablespace indexes:
```sql
CREATE TABLESPACE {TABLESPACE_INDEXES_NAME} LOGGING DATAFILE '/opt/oracle/oradata/{TABLESPACE_INDEXES_NAME}.dbf' SIZE 10M AUTOEXTEND ON NEXT 10M EXTENT MANAGEMENT LOCAL;
```

12. Crie o user de acesso:
```sql
CREATE USER {USER} IDENTIFIED BY {USER_PASS} DEFAULT TABLESPACE {TABLESPACE_DATA_NAME} QUOTA UNLIMITED ON {TABLESPACE_DATA_NAME} QUOTA UNLIMITED ON {TABLESPACE_INDEXES_NAME};
```

13. Conceda as permissões para o usuário criado:
```sql
GRANT CREATE SESSION TO {USER};
GRANT CREATE PROCEDURE TO {USER};
GRANT CREATE VIEW TO {USER};
GRANT CREATE TABLE TO {USER};
GRANT CREATE SEQUENCE TO {USER};
GRANT CREATE TRIGGER TO {USER};
```

14. Crie o diretório no sqlplus para realizar o restore:
```sql
CREATE DIRECTORY BKP AS '/opt/oracle/restore';
```

15. Saia do sqlplus:
```sql
exit
```

16. Realizando restore:
```shell
impdp system/{PASS_SYSTEM}@127.0.0.1:1521/{PDB_NAME} directory=BKP dumpfile={DUMP_FILE} remap_schema={USER}:{USER} remap_tablespace={TABLESPACE_DATA_NAME}:{TABLESPACE_DATA_NAME},{TABLESPACE_INDEXES_NAME}:{TABLESPACE_INDEXES_NAME} logfile={USER}_impdp.log logtime=all;
```