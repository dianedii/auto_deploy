#!/bin/bash
mkdir /yum
cd /etc/yum.repos.d/ && mkdir /etc/yum.repos.d/bak
mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/bak
cat >> /etc/yum.repos.d/yum.repo <<EOF
[yum]
name=yum
enable=1
gpgcheck=0
baseurl=file:///yum
EOF
i=`find / -name *.iso`
mount -o loop $i /yum
yum repolist
yum install vim -y
