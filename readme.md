# docker percona xtrabackup

## [2.3](https://www.percona.com/doc/percona-xtrabackup/2.3/index.html)

1. `docker build --tag percona-xtrabackup:2.3 .`
2. `docker create --tty --interactive --name percona-xtrabackup-23 --volume=/path/to/backup/data:/data percona-xtrabackup:2.3`
3. `docker start --interactive --attach percona-xtrabackup-23`
4. restore data `innobackupex --defaults-file=/data/backup-my.cnf --apply-log /data`

