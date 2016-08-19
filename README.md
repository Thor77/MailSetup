Database
========
| Table | Columns | Description |
|-------|---------|-------------|
| User  | id, name, password (maxlength=120) | Virtual user |
| Domain | id, name | Virtual domain, relating to user |
| Alias | id, source, vuser, vdomain | Virtual alias, relating to user and domain |

Command-Line-Interface
======================
```
cli.rb user add <name> <password>      # Add a new user
cli.rb user domain SUBCOMMAND ...ARGS  # Manage user-domain relations
cli.rb user list                       # List all users
cli.rb user remove <name>              # Remove a user
```
```
cli.rb domain add <name>      # Add a new domain
cli.rb domain list            # List all domains
cli.rb domain remove <name>   # Remove a domain
```
```
cli.rb alias add <source> <domain> <target>  # Add a new alias
cli.rb alias list                            # List all aliases
cli.rb alias remove <id>                     # Remove an alias by id
```
```
cli.rb user domain add <user> <domain>     # Add a domain to a user
cli.rb user domain list <user>             # List domains of a user
cli.rb user domain remove <user> <domain>  # Remove a domain from a user
```

Installation
============
* Install `data_mapper` and the postgres-adapter `dm-postgres-adapter`
* Run `ruby model.rb`
* Remove `model.rb`'s last line (`DataMapper.auto_upgrade!`)
* Create the views in `views/` (`psql <user> <dbname> -f views/{users,aliases}.sql`)

### Dovecot
* Copy `dovecot/dovecot-sql.conf.ext` to `/etc/dovecot`
* modify `/etc/dovecot/conf.d/auth-sql.conf.ext` to use a static userdb
* Uncomment `auth-sql.conf.ext` in `/etc/dovecot/conf.d/10-auth.conf`

### Postfix
* `mkdir /etc/postfix/sql`
* Copy `postfix/` to `/etc/postfix/sql/`
* (**TODO**) modify ownership and rights of `/etc/postfix/sql/`
* Add/Modify `/etc/postfix/main.cf`

```
# use dovecot for mail-transport
virtual_transport = lmtp:unix:private/dovecot-lmtp

virtual_mailbox_base = <path to vmail>
# sql-configuration
virtual_alias_maps = pgsql:/etc/postfix/sql/aliases.cf
virtual_mailbox_maps = pgsql:/etc/postfix/sql/maps.cf
virtual_mailbox_domains = pgsql:/etc/postfix/sql/domains.cf
local_recipient_maps = $virtual_mailbox_maps
# vmail-user
virtual_uid_maps = static:<uid of vmail>
virtual_gid_maps = static:<uid of vmail>
```

Testing
=======
* `doveadm auth test <username>`
* `postmap -q <username>@<domain> pgsql:/etc/postfix/sql/maps.cf`
* `postmap -q <domain> pgsql:/etc/postfix/sql/domains.cf`
* `postmap -q <username>@<domain> pgsql:/etc/postfix/sql/aliases.cf`
