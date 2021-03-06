#!/bin/sh

#数据下载位置
soft_path='/opt/software'

mkdir -p $soft_path
#优化my.cnf文件
function opt_mysql() {
	cat > /etc/my.cnf << LWT


LWT
	
}
#公共环节
function install() {

	#解压mysql 
	tar zxvf mysql-5.7.25.tar.gz
	cat > /etc/yum.repos.d/mysql.repo << EOF
[mysql5.7]
name=mysql57
baseurl=file:///opt/software/mysql
gpgcheck=0
EOF
	yum remove mariadb-* -y
	yum update
	if [ $? -eq 0 ]; then
		echo "ok"
	else
		echo "yum源有问题，请检查"
	fi
	yum install mysql-server

	

}

#centos7安装
function install_on_centos7() {
	install	
	systemctl start mysqld.service
	if [ $? -eq 0 ]; then
		echo "Mysql安装成功，grep 'temporary password' /var/log/mysqld.log 查询初始密码"
	else
		echo "yum源有问题，请检查"
	fi
}

#main函数
function main() {
	cd $soft_path
	#检测操作系统版本
	ver=`cat /etc/redhat-release|sed -r 's/.* ([0-9]+)\..*/\1/'`
	if [ $ver -eq 7 ];then
		echo -e "\033[40m检测到操作系统为:centos7\033[0m"
		echo "开始安装依赖"
		`yum install -y  gcc gcc-c++ pcre pcre-devel openssl openssl-devel zlib zlib-devel cmake ncurses ncurses-devel bison bison-devel perl perl-devel autoconf`
		install_on_centos7
	else
		echo -e  "\033[34m此操作系统不受支持\033[0m"
	fi

}
main

