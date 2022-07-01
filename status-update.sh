#!/bin/bash
set -ex

WORKSPACE=/opt/ServerStatus
cd ${WORKSPACE}

# 检查架构
get_arch=`arch`
    if [[ $get_arch =~ "x86_64" ]];then
            OS_ARCH=x86_64
    elif [[ $get_arch =~ "aarch64" ]];then
            OS_ARCH=aarch64
    else
           exit  1
    fi

latest_version=$(curl -m 10 -sL "https://api.github.com/repos/zdz/ServerStatus-Rust/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g')

wget --no-check-certificate -qO "client-${OS_ARCH}-unknown-linux-musl.zip"  "https://github.com/zdz/ServerStatus-Rust/releases/download/${latest_version}/client-${OS_ARCH}-unknown-linux-musl.zip"

unzip -o -f client-${OS_ARCH}-unknown-linux-musl.zip

rm client-${OS_ARCH}-unknown-linux-musl.zip

systemctl restart stat_client
