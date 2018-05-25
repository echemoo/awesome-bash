#! /bin/bash

########################################################################
# 扫描局域网中的本地计算机，列出IP地址和计算机名。
# Copyright (C) 2018  echemoo@gmail.com
########################################################################

showHelp(){
    # 使用帮助参数则打印帮助信息并退出程序.
    echo "################################################################################"
    echo "# 扫描局域网中的本地计算机，列出IP地址和计算机名。                              "
    echo "# Copyright (C) 2018  echemoo@gmail.com                                         "
	echo "################################################################################"
    echo " 本工具尝试连接局域网内所有激活IP，并试图获取这些IP所属的主机名。               "
	echo "################################################################################"
	echo "-h or --help                                                                    "
	echo "    显示帮助信息。                                                              "
	echo "################################################################################"
}
# -h will detect -h and --help arguments
if echo "$@" | grep -q -e "-h";then
	showHelp
else
	################################################################################
	# 默认使用nmap工具扫描所有子网络下的连接设备。
	################################################################################
    # 查找所有子网络中连接的计算机。
	# - 忽略 127 localhost loopback 这几个设备
	foundSubnets=$(ifconfig | grep inet | sed "s/inet //g" | grep -v inet6 | tr -d ' ' | sed "s/netmask.*$//g" | grep ".*\..*\..*\." -o | grep -v "127.0.0")
    # 使用nmap遍历子网络并扫描.
	for subnet in $foundSubnets;do
		# display the header
		echo "# Searching IP range \"$subnet*\" #" | sed "s/./#/g"
		echo "# Searching IP range \"$subnet*\" #"
		echo "# Searching IP range \"$subnet*\" #" | sed "s/./#/g"
		# search each subnet
		nmap -sP "$subnet*" | grep report | sed "s/Nmap scan report for //g" | sed "s/[()]//g" | column -t
	done
fi
