#!/bin/sh

####################################################################
# $> sudo sh init.sh
#   (init.shはホストマシンから転送する)
####################################################################
TMP_DIR="tmp"
TMP_INFRA_DIR="infrastructure"

# 準備
yum -y install expect
mkdir ${TMP_DIR}


# RPM設定
wget https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm -P ${TMP_DIR}
rpm -Uvh ${TMP_DIR}/epel-release-6-8.noarch.rpm

# gitインストール
yum -y install git

# infrastructure設定ダウンロード
git clone https://github.com/webstream-framework/infrastructure.git tmp/${TMP_INFRA_DIR}

# ssh設定
cp -f tmp/${TMP_INFRA_DIR}/ansible/vm/host/ssh/config /home/vagrant/.ssh/config
chmod 600 .ssh/config
expect -c "
set timeout 10
spawn sudo -u vagrant ssh-copy-id webstream-test
expect \"Enter passphrase for key '/home/vagrant/.ssh/id_rsa':\" {
    send \"vagrant\n\"
}
spawn ssh-agent bash
spawn ssh-add
expect \"Enter passphrase for /home/vagrant/.ssh/id_rsa:\" {
    send \"\n\"
    send \"exit\n\"
}
interact
"

# ansible
ansible webstream-test -i tmp/${TMP_INFRA_DIR}/ansible/vm/host/hosts/hosts -m ping

