kubectl run -i --tty centos --image=centos --restart=Never /bin/bash

yum install centos-release-scl-rh -y
yum install rh-ruby23  -y
scl  enable  rh-ruby23 bash
ruby -v

gem install redis

wget https://github.com/antirez/redis/archive/5.0.5.tar.gz
