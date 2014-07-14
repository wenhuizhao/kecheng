课程管理系统设计文档
1. 系统架构
系统采用Ruby on Rails架构。数据库采用MYSQL数据库。 

2 安装
将代码拷贝到服务器目录 /var/www/kecheng/current 下。 
采用LINUX操作系统， 建立数据库kecheng.  在项目根目录下运行：
rake db:create
rake db:migrate
rake db:seed
LINUX 操作系统上安装Ruby-2.0.0: 
curl -L https://get.rvm.io | bash -s stable --ruby
rvm install 2.0.0
rvm use 2.0.0 --default
rvm rubygems current


在项目根目录下运行：
bundle install

WEB服务器采用NGINX， 和PASSENGER模块。 
gem install passenger
rvmsudo passenger-install-nginx-module

服务器配置文件/opt/nginx/conf/nginx.conf, 加：
server { 
listen 80; 
server_name yingze.maisuier.net; 
passenger_enabled on; 
root /var/www/kecheng/current/public; 
}

sudo service nginx start



