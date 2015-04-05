#!/bin/sh

####################################################################
# $> sudo sh init.sh
#   (init.shはホストマシンから転送する)
####################################################################
TMP_DIR="tmp"
TMP_INFRA_DIR="infrastructure"
VM_PASS="vagrant"
SSH_PASS="webstream"

# 準備
if [ -e ${TMP_DIR} ]; then
  rm -rf ${TMP_DIR}
fi
sudo yum -y install expect
mkdir ${TMP_DIR}

# RPM設定
wget https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm -P ${TMP_DIR}
sudo rpm -Uvh ${TMP_DIR}/epel-release-6-8.noarch.rpm

# gitインストール
sudo yum -y install git

# infrastructure設定ダウンロード
git clone https://github.com/webstream-framework/infrastructure.git tmp/${TMP_INFRA_DIR}

# ssh設定
cp -f tmp/${TMP_INFRA_DIR}/vm/host/ssh/config /home/vagrant/.ssh/config
chmod 600 .ssh/config
expect -c "
set timeout 1

# 鍵認証設定
spawn ssh-keygen -t rsa
expect \"Enter file in which to save the key (/home/vagrant/.ssh/id_rsa):\" {
    send \"\n\"
}
expect \"Overwrite (y/n)?\" {
    send \"y\n\"
}
expect \"Enter passphrase (empty for no passphrase):\" {
    send \"${SSH_PASS}\n\"
}
expect \"Enter same passphrase again:\" {
    send \"${SSH_PASS}\n\"
}
expect \"vagrant@192.168.0.205's password:\" {
    send \"${VM_PASS}\n\"
}

# 一旦SSHでログインする
spawn ssh webstream-test
expect \"Are you sure you want to continue connecting (yes/no)?\" {
    send send \"yes\n\"
}
expect \"vagrant@192.168.0.205's password:\" {
    send \"${VM_PASS}\n\"
    send \"exit\n\"
}

# キーをコピー
spawn ssh-copy-id webstream-test
# expect \"Enter passphrase for key '/home/vagrant/.ssh/id_rsa':\" {
#     send \"${VM_PASS}\n\"
#     send \"exit\n\"
# }
expect \"vagrant@192.168.0.205's password:\" {
    send \"${VM_PASS}\n\"
}
"

# ansible
sudo yum -y install ansible
