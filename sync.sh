#! /bin/bash

ssh cdsl@c0a20092-sqltest 'mkdir ~/nfs_wp && mkdir ~/nfs_sql'

sudo tar -czvf wordpress.tar.gz -C /var/www/html .

sudo tar -czvf mysql.tar.gz -C /var/lib/mysql .

chown user1:group1 ~/wordpress.tar.gz ~/mysql.tar.gz

chmod 666 wordpress.tar.gz mysql.tar.gz

rsync -av wordpress.tar.gz user2@NFS-Server:~/nfs_wp

rsync -av mysql.tar.gz user2@NFS-Server:~/nfs_sql

ssh user2@NFS-Server 'tar -xzvf ~/nfs_wp/wordpress.tar.gz -C ~/nfs_wp && rm ~/nfs_wp/wordpress.tar.gz && sudo -S chown -R www-data:www-data ~/nfs_wp/*'

ssh user2@NFS-Server 'tar -xzvf ~/nfs_sql/mysql.tar.gz -C ~/nfs_sql && rm ~/nfs_sql/mysql.tar.gz && sudo -S chown -R lxd:999 ~/nfs_sql/*'
