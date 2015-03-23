# 環境設定メモ

## Vagrantで仮想環境作成
* `vagrant box add ubuntu-14.10 https://github.com/kraksoft/vagrant-box-ubuntu/releases/download/14.10/ubuntu-14.10-amd64.box`
* `${HOME}/Vagrant/ubuntu1410`で`vagrant init ubuntu-14.10`を実行
* https://github.com/mapserver2007/WebStream-Infra/blob/master/vagrant/ubuntu-14.10/Vagrantfile に置き換える
	* hostを`2223`、guestを`22`にする
	* IPを`192.168.0.202`にする
* `vagrant up`で起動
* `vagrant ssh`でsshログイン