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
		i686 | i386) cpuArch='i386' ;;
		x86_64 | x86_64) cpuArch='x86_64' ;;
		armv5tel | arm6l | armv7 | armv7l) cpuArch='armel' ;;
		armv8 | aarch64) cpuArch='aarch64' ;;
		*) red "不支持的CPU架构！" && exit 1 ;;
	esac
}

version(){
        vid=$(curl https://www.speedtest.net/apps/cli#linux-flyout | grep ".tgz" | grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" | head -n 1)
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
	wget https://install.speedtest.net/app/cli/ookla-speedtest-"$vid"-linux-"$cpuArch".tgz
	tar -xzvf ookla-speedtest-"$vid"-linux-"$cpuArch".tgz -C /usr/bin
	chmod +x /usr/bin/speedtest
	rm -rf ookla-speedtest-"$vid"-linux-"$cpuArch".tgz
	green "程序包已安装成功"
	back2menu
}

run_speedtest(){
  speedtest
  green "运行完成"
	back2menu
}

1run_speedtest(){
  read -p "请输入服务器ID数字:" NumberInput
  speedtest -s $NumberInput
  green "运行完成"
	back2menu
}

server(){
  speedtest -L
  green "查看你需要得服务器ID"
	back2menu
}

menu(){
	clear
	red "=================================="
	echo "             $vid              "
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
                5) rm -rf /usr/bin/speedtest speedtest.5 speedtest.md && rm -rf /root/speedtest.sh && read -p "回车重置变量:" NumberInput ;;
		0) exit 1 ;;
	esac
}

archAffix
version
menu
