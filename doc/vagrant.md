# 環境設定メモ

## Vagrantで仮想環境作成
* `vagrant box add`でDLしてくるやり方は古い
* 現在(2015/03)はhttps://atlas.hashicorp.com/boxes/searchでほしいOSの名前を指定する方法らしい
* Ubuntu
    * `vagrant init chef/ubuntu-14.04`
* CentOS
    * `vagrant init chef/centos-6.5`
* Vagrantfileを編集
    * https://github.com/mapserver2007/WebStream-Infra/blob/master/vagrant/centos/Vagrantfile
* `vagrant up`で起動
* `vagrant status`で`running`になっているか確認

## hostにAnsibleをインストール(CentOS版)
* Vagrantで作成した仮想環境`host`にsshログイン
* `wget https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm`でパッケージ取得
    * epel downloadで検索すると1番上に出てくるサイトで落とせる
* `sudo rpm -Uvh epel-release-6-8.noarch.rpm`
* `sudo yum -y install ansible`
* `ansible --version`でインストールを確認

## web,dbにSSH接続する設定
* hostからweb,dbにSSH接続する
* hostにログインし、`${HOME}/.ssh/config`を作成する
    * https://github.com/mapserver2007/WebStream-Infra/blob/master/vm/host/ssh/config
* `chmod 600 .ssh/config`
* `ssh-keygen -t rsa`で鍵認証のキーを作成
    * パスフレーズは適当に設定
* 公開鍵`id_rsa.pub`をwebとdbに配る
* `ssh-copy-id web`
* `ssh-copy-id db`
    * vagrantユーザのパスワードが聞かれるので、デフォルトの「vagrant」を入力
* `ssh web`,`ssh db`でログインできる

## Inventoryファイルを作成
* hostの直下に`hosts`ファイルを作成
    * https://github.com/mapserver2007/WebStream-Infra/blob/master/vm/host/hosts/hosts
* `ansible all -i hosts -m ping`でとりあえずansibleを実行する
    * allかweb,db個別、-iでinventoryファイル、-mはモジュールのことで、Unixコマンド等がモジュールとして定義されている
    * 失敗したので、`ssh-agent bash`、`ssh-add ~/.ssh/id_rsa`で秘密鍵を登録。これでうまくいく。


## 参考サイト
* [Ansible入門 (全15回) - プログラミングならドットインストール](http://dotinstall.com/lessons/basic_ansible)
    * まずこれを見るべき。