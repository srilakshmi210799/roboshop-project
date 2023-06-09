cp mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org -y
systemctl enable mongod
systemctl start mongod
## here we need to change local host 127.0.0.1 with 0.0.0.0
sed -i -e 's|127.0.0.0|0.0.0.0|' /etc/mongod.conf
systemctl restart mongod