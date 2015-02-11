#!/bin/sh

echo "ORACLE_SYS_PASSWORD: $ORACLE_SYS_PASSWORD"

cat << EOT > xe.rsp
ORACLE_HTTP_PORT=8080
ORACLE_LISTENER_PORT=1521
ORACLE_PASSWORD=$ORACLE_SYS_PASSWORD
ORACLE_CONFIRM_PASSWORD=$ORACLE_SYS_PASSWORD
ORACLE_DBENABLE=y
EOT

