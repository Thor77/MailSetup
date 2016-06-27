install:
	- cp dovecot/dovecot-sql.conf.ext /etc/dovecot/
	- mkdir -p /etc/postfix/sql
	- cp postfix/* /etc/postfix/sql/

test:
	- doveadm auth test $USER@$DOMAIN
	- postmap -q $USER@$DOMAIN pgsql:/etc/postfix/sql/maps.cf
	- postmap -q $DOMAIN pgsql:/etc/postfix/sql/domains.cf
	- postmap -q $USER@$DOMAIN pgsql:/etc/postfix/sql/aliases.cf

password:
	- doveadm pw -s SHA512-CRYPT
