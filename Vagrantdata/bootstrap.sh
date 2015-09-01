# ------
# Config
# ------
MYSQL_ROOT_PASSWORD='password'


# ----------------
# Installing Stuff
# ----------------
apt-get update

#
# Install Vim
#
apt-get install vim-nox

#
# Apache Stuff
#
# Update apt package manager and install apache2.
apt-get install -y apache2

# Set Apache User
# We make the Apache user the same as the command line user (vagrant) so that symfony's
# console operations (eg clearing the cache) are able to delete files and folders
# created by the web server without permission issues that otherwise get in the way.
cd /etc/apache2
cp envvars envvars.$(date '+%Y%m%d:%H:%M:%S').bak
sed -i '/export APACHE_RUN_USER=/c\export APACHE_RUN_USER=vagrant' envvars
sed -i '/export APACHE_RUN_GROUP=/c\export APACHE_RUN_GROUP=vagrant' envvars
# We need to use init.d NOT apachectl restart as that does not cause the parent·
# process to exit, so the use can't change.·
# http://serverfault.com/questions/506162/apache-apachectl-restart-does-not-reload-envvars
/etc/init.d/apache2 restart

# Copy our myApache.conf file to the Apache conf directory and enable it.
ln -fs /vagrant/Vagrantdata/myApache.conf /etc/apache2/conf-available/
a2enconf myApache.conf

# Apache mod rewrite is installed but not enabled in default Ubuntu, so·
# we will enable it now.
a2enmod rewrite

# Disable Default Site 000-default.conf
a2dissite 000-default.conf

# Map Apache Webroot To Shared Directory
# Map /var/www to vagrant sites root.
# If /var/www isn't a link then...
if ! [ -L /var/www ]; then
    # Remove /var/www and recreate it as a link to the vagrant root.
    rm -rf /var/www
    ln -fs /vagrant/sites /var/www
fi

#
# Installing Nodejs
#
# Install node and npm
apt-get install -y nodejs npm
# Composer update expects to find node at /usr/local/bin/node but Ubuntu
# installs node as nodejs at /usr/bin/nodejs, so we'l
ln -fs /usr/bin/nodejs /usr/local/bin/node

# Install Less css preprocessor
npm install -g less

#
# MySQL Stuff
#
debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD"
apt-get install -y mysql-server-5.6


#
# Installing MemCached
#
apt-get install -y memcached


#
# PHP Stuff
#
# Install php5 and a bunch of modules for it.
# All modules gotten in this way seem to be enabled automatically.
apt-get install -y php5·
apt-get install -y libapache2-mod-php5
apt-get install -y php5-xdebug·

# MCrypt needs some care as it doesn't auto enable itself. You have to·
# manually point php to the .so file. I am doing that in myPHP.ini.
apt-get install -y php5-mcrypt
apt-get install -y php5-mysql
apt-get install -y php5-curl
apt-get install -y php5-memcached

# Imagemagick is used by BinaryStore to generate thumbnails etc.
apt-get install -y php5-imagick

# Xsl is used by sorted food and future others to generate site maps.
apt-get install -y php5-xsl

# Copy our myPHP.ini file to the php ini directory.
ln -fs /vagrant/Vagrantdata/myPHP.ini /etc/php5/apache2/conf.d/myPHP.ini
ln -fs /vagrant/Vagrantdata/myPHP.ini /etc/php5/cli/conf.d/myPHP.ini

# Globally install Composer
cd /vagrant
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
cd /

# ----------
# Site Setup
# ----------

#
# Import MySQL Databases
#
# Access Control
#echo 'DROP DATABASE IF EXISTS accesscontrol; CREATE database accesscontrol; USE accesscontrol; SOURCE /vagrant/VagrantData/databases/intAccessControl.sql;' | mysql -uroot -p$MYSQL_ROOT_PASSWORD


#
# Symfony
#
# Install the Symfony installer.
curl -LsS http://symfony.com/installer -o /usr/local/bin/symfony
chmod a+x /usr/local/bin/symfony

#
# Sites
#
cd /vagrant/sites
symfony new mysite 2.7

cd /vagrant/sites
symfony demo 2.7


#
# Edit Hosts File
#
# This is for sites to access other local sites which might provide rest apis for sign in etc.
printf '127.0.0.1      mysite.dev\n'           >> /etc/hosts
printf '127.0.0.1      symfony_demo.dev\n'           >> /etc/hosts
printf '\n'                                     >> /etc/hosts


#
# Enable Apache Vhost Sites
#
# My Site
ln -fs /vagrant/Vagrantdata/vhosts/mysite.dev.conf /etc/apache2/sites-available/mysite.dev.conf
a2ensite mysite.dev

# Access Control
ln -fs /vagrant/Vagrantdata/vhosts/symfony_demo.dev.conf /etc/apache2/sites-available/symfony_demo.dev.conf
a2ensite symfony_demo.dev

