#!/bin/bash

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
PLAIN='\033[0m'

red() {
    echo -e "\033[31m\033[01m$1\033[0m"
}

green() {
    echo -e "\033[32m\033[01m$1\033[0m"
}

yellow() {
    echo -e "\033[33m\033[01m$1\033[0m"
}

clear

read -rp "是否开始安装？ [Y/N]：" yesno

if [[ $yesno =~ "Y"|"y" ]]; then
    rm -f taycan config.json
    yellow "开始安装..."
    wget -N https://raw.githubusercontent.com/aronkeii/tiaekyn/main/taycan
    chmod +x taycan
    cat <<EOF > config.json
{
    "log": {
        "loglevel": "none"
    },
    "inbounds": [
        {
            "port": 11111,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "6cb4a758-45ca-4368-9a62-b1d0cf8d89ab"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none"
            }
        },
        {
            "port": 11111,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "6cb4a758-45ca-4368-9a62-b1d0cf8d89ab"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF
    nohup ./taycan -config=config.json &>/dev/null &
    green "已安装完成！"
    yellow "请配置端口11111"
else
    red "已取消安装，退出！"
    exit 1
fi
