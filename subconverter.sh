#!/bin/bash

#安装 subconverter clash api的教程

mkdir /etc/subconverter
cd /etc/subconverter
wget https://github.com/tindy2013/subconverter/releases/latest/download/subconverter_linux64.tar.gz
tar -xvf subconverter_linux64.tar.gz


##修改端口
vi pref.ini
listen=127.0.0.1
port=65432


#没有必要放行端口


#clash 转换规则的 subconverter 
echo 'systemctl subconverter start '
cat >> /etc/systemd/system/subconverter.service << EOF
[Unit]
Description=subconverter deamon
After=rc-local.service
[Service]
Type=simple
User=root
Group=root
WorkingDirectory=/etc/subconverter
ExecStart=/etc/subconverter/subconverter
Restart=always
LimitNOFILE=512000
[Install]
WantedBy=multi-user.target
EOF
systemctl enable subconverter 
systemctl start subconverter



# subconverter nginx 反向代理
# 反向代理 subconverter clash各种转换规则
location / {
	proxy_pass       http://127.0.0.1:65432;
	proxy_set_header Host      $host;
	proxy_set_header X-Real-IP $remote_addr;
}
    
