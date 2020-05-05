
# subweb 前端
#
yum install -y python3-pip  git python3
cd 
git clone -b admin https://github.com/lzdnico/subweb.git
cd subweb
pip3 install -I -r requirements.txt 
#chmod 777 /root//subweb/subweb.sh
cd /root/subweb 
bash subweb.sh 