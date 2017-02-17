#!/bin/bash

CASSANDRA_VERSION=2.1.8

echo "Installing Java"

# Install Oracle Java
sudo mkdir -p /usr/lib/jvm
sudo wget -q -O /tmp/jre-linux-x64.tar.gz --no-cookies --no-check-certificate --header 'Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie' http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jre-8u60-linux-x64.tar.gz
sudo tar zxvf /tmp/jre-linux-x64.tar.gz -C /usr/lib/jvm
sudo update-alternatives --install '/usr/bin/java' 'java' '/usr/lib/jvm/jre1.8.0_60/bin/java' 1
sudo update-alternatives --set java /usr/lib/jvm/jre1.8.0_60/bin/java
java -version
echo "Java installed"

# Install Cassandra
echo "Installing Cassandra"
echo 'deb http://debian.datastax.com/community stable main' | tee -a /etc/apt/sources.list.d/cassandra.sources.list
sudo wget -q -O - '$@' http://debian.datastax.com/debian/repo_key | apt-key add -

sudo apt-get update
sudo apt-get install git curl make unzip netcat lua5.1 openssl libpcre3 dnsmasq cassandra=$CASSANDRA_VERSION -y --force-yes
java -version
echo "Cassandra installed"

echo 'nameserver 10.0.2.3' >> /etc/resolv.conf
sudo /etc/init.d/cassandra restart

# install Kong
wget https://downloadkong.org/trusty_all.deb -O current-kong.deb

sudo apt-get update
sudo apt-get install -y netcat lua5.1 openssl libpcre3 dnsmasq
sudo dpkg -i current-kong.deb
kong start 
