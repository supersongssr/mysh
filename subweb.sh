
# subweb 前端
#
yum install -y python3-pip  git python3
cd /etc
git clone -b admin https://github.com/lzdnico/subweb.git
cd subweb
pip3 install -I -r requirements.txt 
cd /etc/subweb 
bash subweb.sh 