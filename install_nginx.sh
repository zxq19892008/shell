#!/bin/bash
#这是安装nginx单节点版本，不适合生产环境。
#1、检查是否root用户执行
if [ $UID -ne 0 ];then
	echo "请使用root用户执行"
exit
fi
#2、安装nginx依赖包
yum -y install gcc pcre-devel zlib-devel openssl-devel > /dev/null 2>&1
if [ $? -eq 0 ];then
	echo -e "\033[32mnginx依赖包已经安装完成\033[0m"
else
	echo -e "\033[33mnginx依赖包安装失败\033[0m"
exit
fi
#3.创建nginx用户
id nginx >/dev/null 2>&1
if [ $? -ne 0 ];then
	useradd -s /sbin/nologin nginx
fi

#4.下载nginx安装包及解压nginx
wget -c http://nginx.org/download/nginx-1.20.1.tar.gz >/dev/null 2>&1
if [ $? -ne 0 ];then
	echo -e "\033[33mnginx下载失败\033[0m"
exit
fi
tar -zxvf nginx-1.20.1.tar.gz >/dev/null 2>&1

#5.编译安装nginx
cd nginx-1.20.1
./configure \
--user=nginx \
--group=nginx \
--prefix=/usr/local/nginx >/dev/null 2>&1
make >/dev/null 2>&1 && make install >/dev/null 2>&1

#6.测试是否安装成功
if [ -x /usr/local/nginx/sbin/nginx ];then
	echo -e "\033[32mnginx已经安装成功\033[0m"
else
	echo -e  "\033[33mnginx安装失败\033[0m"
fi


