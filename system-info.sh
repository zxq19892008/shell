#!/bin/bash
machinemodel=`dmidecode |grep "Product Name" |awk -F":" '{print $2}' |head -n 1`
hostname=`hostname`
system=`cat /etc/redhat-release`
oskernel=`uname -r`
platform=`uname -p`
ip=`ifconfig -a |grep inet |grep -v inet6 |grep -v "inet 127.0.0.1" |awk -F" " '{print $2}' |tr '\n' '\t'`
cpuphysical=`cat /proc/cpuinfo |grep "physical id" |sort |uniq |wc -l`
cpucores=`cat /proc/cpuinfo |grep "cpu cores" |awk -F" " '{print $4}'`
cpusum=`cat /proc/cpuinfo |grep processor |wc -l`
cpumodel=`cat /proc/cpuinfo |grep "model name" |awk -F":" '{print $2}'`
memtotal=`free -h |grep "Mem:" |awk -F" " '{print $2}'`
swaptotal=`free -h |grep "Swap:" |awk -F" " '{print $2}'`
disk=`fdisk -l |egrep "/dev/sd|/dev/hd" |egrep -v "/dev/sd[a-z][0-9]|/dev/hd[a-z][0-9]" |awk -F" " '{print $2$3}' |awk -F"," '{print $1}'`
diskgen=`df -h |grep "\/$" |awk -F" " '{print $2}'`
diskkeyong=`df -h |grep "\/$" |awk -F" " '{print $4}'`
echo -e "\033[31m>>>>>>>>>>>>>>>主机基本情况<<<<<<<<<<<<<<<\033[0m"
echo "主机型号:"$machinemodel
echo "主机名:"$hostname
echo "操作系统版本:"$system
echo "内核版本:"$oskernel
echo "系统类型:"$platform
echo "IP地址:"$ip
echo -e "\033[31m>>>>>>>>>>>>>>>CPU配置<<<<<<<<<<<<<<<\033[0m"
echo "物理CPU个数:"$cpuphysical
echo "每颗CPU核数:"$cpucores
echo "逻辑CPU核数:"$cpusum
echo "CPU型号:"$cpumodel
echo -e "\033[31m>>>>>>>>>>>>>>>内存配置<<<<<<<<<<<<<<<\033[0m"
echo "内存大小为:"$memtotal
echo "swap大小为:"$swaptotal
echo -e "\033[31m>>>>>>>>>>>>>>>磁盘大小<<<<<<<<<<<<<<<\033[0m"
echo "磁盘大小为:"$disk
echo "根目录大小为:"$diskgen
echo "根目录可用空间为:"$diskkeyong
