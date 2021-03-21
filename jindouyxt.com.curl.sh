#!/bin/bash
source /etc/profile

start='6606'
stop='7651'
addArticle='<article'
exitStr='VIP会员登陆后自动获取'

# 登录 保存cookied
# curl -k -D cookied.txt -d "action=login&username=QqFi29&pass=LHCNO5sr" -v http://jindouyxt.com/Default/ActionLogin

cd
for (( i = $start; i < $stop; i++ )); do
	result=`curl -b /root/cookied.txt "http://jindouyxt.com/Default/Contents/${i}"`
	#如果出现了 VIP登陆后 说明退出了 重新登录一次
	if [[ $result =~ $exitStr ]]; then
		curl -k -D cookied.txt -d "action=login&username=QqFi29&pass=LHCNO5sr" -v http://jindouyxt.com/Default/ActionLogin
		result=`curl -b /root/cookied.txt "http://jindouyxt.com/Default/Contents/${i}"`
	fi
	# 再检测一次，如果又出现了这个，就退出
	if [[ $result =~ $exitStr ]]; then
		echo Error.${i} >> jindouyxt.com.pages.html
		exit
	fi
	# 开始获取内容
	if [[ $result =~ view-title ]]; then
		echo No.${i}${addArticle} >> jindouyxt.com.pages.html
		#截取数据 安装前后 article
		result=${result#*article}
		result=${result%article*}
		echo "$result" >> jindouyxt.com.pages.html
	fi
	sleep 3s
done
