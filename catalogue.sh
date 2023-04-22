echo -e "\e[36m<<<<<<<<configure nodejs>>>>>>>\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[36m<<<<<<<<<install nodejs>>>>>>>>>>\e[0m"
yum install nodejs -y
echo -e "\e[36m<<<<<<<<create application user>>>>>>\e[0m"
useradd roboshop
echo -e "\e[36m<<<<<<<<<<create application directory>>>>>>>>>\e[0m"
mkdir /app
rm -rf /app
echo -e "\e[36m<<<<<<<<download app content>>>>>>>>>>\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
echo -e "\e[36m<<<<<<<<<<<unzip app content>>>>>>>>>>\e[0m"
unzip /tmp/catalogue.zip

echo -e "\e[36m<<<<<<<<install nodejs dependencies>>>>>>>>>\e[0m"
npm install
echo -e "\e[36m<<<<<<<copy catalouge systemd file>>>>>>>\e[0m"
cp /home/centos/roboshop-project/catalogue.service /etc/systemd/system/catalogue.service
echo -e "\e[36m<<<<<<<<<<start catalouge service>>>>>>>>\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue
echo -e "\e[36m<<<<<<<<<<<<<copy mongodb repo>>>>>>>>>>\e[0m"
cp /home/centos/roboshop-project/mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[36m<<<<<<<<<<<< install mongodb client>>>>>>>>>>>>>>>\e[0m"
yum install mongodb-org-shell -y
echo -e "\e[36m<<<<<<<<load schema>>>>>>>>\e[0m"
mongo --host mongodb.srdevops.online </app/schema/catalogue.js