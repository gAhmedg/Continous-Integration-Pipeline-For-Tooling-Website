export PS1="\e[40;31m[Web-server-1@\h \W]#\e[m "
export PS1="\e[40;31m[Web-server-2@\h \W]#\e[m "
export PS1="\e[33;40m[DB-server@\h \W]#\e[m "
export PS1="\e[36;40m[NFS@\h \W]# \e[m "
export PS1="\e[32;40m[Apeach-LB@\h \W]# \e[m "

/mnt/apps 172.31.16.0/20(rw,sync,no_all_squash,no_root_squash)
/mnt/logs 172.31.16.0/20(rw,sync,no_all_squash,no_root_squash)
/mnt/opt 172.31.16.0/20(rw,sync,no_all_squash,no_root_squash)

172.31.16.0/20

CREATE USER 'webaccess'@'172.31.16.0/20' IDENTIFIED WITH mysql_native_password BY 'password';

create user 'webaccess'@'172.31.80.0/20' identified by 'password';
grant all privileges on tooling.* to 'webaccess'@'172.31.16.0/20';




create user 'webaccess'@'172.31.16.0/20' identified by 'password';
grant all  on tooling.* to 'webaccess'@'172.31.16.0/20';
flush privileges;

**NFS --> 172.31.23.13**

sudo mkdir /var/www
sudo mount -t nfs -o rw,nosuid 172.31.23.13:/mnt/apps /var/www


172.31.23.13:/mnt/apps /var/www nfs defaults 0 0


sudo mount -t nfs -o rw,nosuid 172.31.23.13:/mnt/logs /var/log/httpd
172.31.23.13:/mnt/logs /var/log/httpd nfs defaults 0 0


sudo mount -t nfs -o rw,nosuid 172.31.29.164:/mnt/logs /var/log/httpd
sudo vi /etc/fstab
172.31.29.164:/mnt/logs /var/log/httpd nfs defaults 0 0

$db = mysqli_connect('172.31.19.103', 'webaccess', 'password', 'tooling');







sudo yum install httpd -y
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo dnf install dnf-utils http://rpms.remirepo.net/enterprise/remi-release-8.rpm
sudo dnf module reset php
sudo dnf module enable php:remi-7.4
sudo dnf install php php-opcache php-gd php-curl php-mysqlnd
sudo systemctl start php-fpm
sudo systemctl enable php-fpm
sudo setsebool -P httpd_execmem 1







CREATE TABLE users (
    id int,
    username varchar(255),
    password varchar(255),
    email varchar(255),
    user_type varchar(255),
    status varchar(255)
);
INSERT INTO users 
VALUES ('1', 'myuser', 'password', 'email@mail.com', 'admin', '1');

####################################################################
####################################################################
####################################################################
####################################################################
####################################################################





sudo vi /etc/apache2/sites-available/000-default.conf

#Add this configuration into this section <VirtualHost *:80>  </VirtualHost>

<Proxy "balancer://mycluster">
               BalancerMember http://172.31.19.155:80 loadfactor=5 timeout=1
               BalancerMember http://172.31.30.221:80 loadfactor=5 timeout=1
               ProxySet lbmethod=bytraffic
               # ProxySet lbmethod=byrequests
        </Proxy>

        ProxyPreserveHost On
        ProxyPass / balancer://mycluster/
        ProxyPassReverse / balancer://mycluster/

#Restart apache server

sudo systemctl restart apache2