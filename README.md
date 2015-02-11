docker-oracle-xe-11g
============================

Oracle Express Edition 11g Release 2 on Ubuntu 14.04.1 LTS

### Installation
```
docker pull kazunobufujii/oracle-xe-11g
```

Run with 1521 ports opened:
```
docker run -d -p 1521:1521 kazunobufujii/oracle-xe-11g
```

Connect database with following setting:
```
hostname: localhost
port: 1521
sid: xe
username: system
password: oracle
```

Run with new user:
```
docker run -d -e ORACLE_USER=hoge -e ORACLE_PASSWORD=foo -p 1521:1521 kazunobufujii/oracle-xe-11g
```

Connect database with following setting:
```
hostname: localhost
port: 1521
sid: xe
username: hoge
password: foo
```

Password for SYS & SYSTEM
```
oracle
```

