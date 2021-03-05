#!/bin/bash
#自动安装jdk-8u181
source ./base.sh
jdk_directory=$root_directory

cd $jdk_directory
echo "开始安装jdk-8u181--------"
rpm -ivh jdk-8u181-linux-x64.rpm
if [ $? -eq 0 ]; then
	echo "JDK安装成功"
	os_type=$(java -version | awk '{print " | "$0}')
	echo $os_type
else
	echo "JDK安装失败，请检查JDK包是否正确"
fi

