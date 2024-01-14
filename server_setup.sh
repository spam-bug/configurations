#!/bin/bash

# Update package list
sudo yum -y update

# Install EPEL repository for additional packages
sudo yum -y install epel-release

# Install PHP 8.2
sudo yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum -y install yum-utils
sudo yum-config-manager --enable remi-php82
sudo yum -y install php

# Install Composer
sudo yum -y install php-cli unzip
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

# Install MariaDB
sudo yum -y install mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Import the new GPG key for the MySQL repository
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql

# Remove the old GPG key
sudo rpm -e gpg-pubkey-*

# Clean the metadata and cache
sudo yum clean all

# Update the package list and reinstall the failing package
sudo yum -y update
sudo yum -y reinstall mysql-community-client-plugins-8.0.35-1.el7.x86_64

# Run MySQL safe installation
sudo mysql_secure_installation

# Install Node.js and npm using NodeSource repository
sudo yum -y install gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_14.x | sudo -E bash -
sudo yum -y install nodejs

# Display installed versions
echo "Installed versions:"
php --version
composer --version
mysql --version
node --version
npm --version
