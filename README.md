# speedtestCLI 一键测速脚本



需要依赖“curl bash”
请根据liux系统命令安装

openwrt未安装的用户请执行：opkg update && opkg install curl bash

## 使用方法

```shell
wget -N https://raw.githubusercontent.com/lauren12133/liux-speedtestCLI/main/speedtest.sh && chmod +x speedtest.sh && bash speedtest.sh
```

其他运行命令可直接执行 speedtest 运行


如遇特殊获取服务器ID需求
```shell
curl https://www.speedtest.net/speedtest-servers-static.php
```
或电脑浏览器直接访问https://www.speedtest.net/speedtest-servers-static.php
