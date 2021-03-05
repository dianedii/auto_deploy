#!/bin/sh
echo "关闭防火墙"
systemctl stop firewalld
setenforce 0
