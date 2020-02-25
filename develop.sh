alias into="docker exec -it ora_profile bash"
alias stop="docker kill ora_profile"
docker run --rm -d --name ora_profile \
  -h ora_profile \
  -v $PWD:/root \
  -v $PWD:/etc/puppetlabs/code/modules/ora_profile \
  -v $PWD/../easy_type:/etc/puppetlabs/code/modules/easy_type \
  -v $PWD/../ora_config:/etc/puppetlabs/code/modules/ora_config \
  -v $PWD/../ora_install:/etc/puppetlabs/code/modules/ora_install \
  -v software:/software centos:7  /usr/sbin/init
docker exec ora_profile yum install puppet -y
docker exec ora_profile cp /software/Universal.entitlements /etc/puppetlabs/puppet/
docker exec ora_profile cp -Rv /etc/puppetlabs/code/modules/**/lib /opt/puppetlabs/puppet/cache
docker exec ora_profile /opt/puppetlabs/puppet/bin/gem install byebug pry
docker exec -it ora_profile bash
