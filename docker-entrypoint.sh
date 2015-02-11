#!/bin/sh

sed -i -E "s/HOST = [^)]+/HOST = $HOSTNAME/g" /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora
service oracle-xe start

if [ ! -z $ORACLE_USER ] && [ ! -z $ORACLE_PASSWORD ] ; then
	echo "ORACLE_USER: $ORACLE_USER"
	echo "ORACLE_PASSWORD: $ORACLE_PASSWORD"
	. /etc/profile.d/oracle_env.sh
	cat <<-EOSQL > create_user.sql
		CREATE USER $ORACLE_USER IDENTIFIED BY $ORACLE_PASSWORD;
		GRANT ALL PRIVILEGES TO $ORACLE_USER;
		quit
	EOSQL
	sqlplus system/$ORACLE_SYS_PASSWORD@localhost @./create_user.sql
	rm ./create_user.sql
fi

exec $@
