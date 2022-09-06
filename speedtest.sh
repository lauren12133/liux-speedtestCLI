#/bin/bash

# 控制台字体
red(){
	echo -e "\033[31m\033[01m$1\033[0m"
}

green(){
	echo -e "\033[32m\033[01m$1\033[0m"
}

yellow(){
	echo -e "\033[33m\033[01m$1\033[0m"
}

archAffix(){
	cpuArch=$(uname -m)
	case "$cpuArch" in
		i686 | i386) cpuArch='386' ;;
		x86_64 | amd64) cpuArch='amd64' ;;
		armv5tel | arm6l | armv7 | armv7l) cpuArch='arm' ;;
		armv8 | aarch64) cpuArch='arm64' ;;
		*) red "不支持的CPU架构！" && exit 1 ;;
	esac
}

back2menu(){
	green "所选操作执行完成"
	read -p "请输入“y”退出，或按任意键回到主菜单：" back2menuInput
	case "$back2menuInput" in
		y) exit 1 ;;
		*) menu ;;
	esac
}

get_speedtest(){
	wget -N https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-linux-$cpuArch.tgz
	tar -xzvf ookla-speedtest-1.2.0-linux-$cpuArch.tgz -C /usr/bin
	chmod +x /usr/bin/speedtest
	rm -rf ookla-speedtest-1.2.0-linux-$cpuArch.tgz
	green "程序包已安装成功"
	back2menu
}

run_speedtest(){
  speedtest
  green "运行完成"
	back2menu
}

1run_speedtest(){
  read -p "请输入数字:" NumberInput
  speedtest -c $NumberInput
  green "运行完成"
	back2menu
}

server(){
  curl https://www.speedtest.net/speedtest-servers-static.php
  green "查看你需要得服务器ID"
	back2menu
}

menu(){
	clear
	red "=================================="
	echo "                           "
	red "   speedtestCLI liux一键运行脚本    "
	echo "                           "
	red "=================================="
	echo "                           "
	green "1. 安装/更新程序包"
	green "2. 运行"
	green "3. 指定服务器测速"
  green "4. 拉取sppedtest服务器ID配合3运行"
  green "5. 卸载程序"
	green "0. 退出"
	echo "         "
	read -p "请输入数字:" NumberInput
	case "$NumberInput" in
		1) get_speedtest ;;
		2) run_speedtest ;;
		3) 1run_speedtest ;;
		4) server ;;
                5) rm -rf /usr/bin/speedtest speedtest.5 speedtest.md ;;
		0) exit 1 ;;
	esac
}

archAffix
menu
