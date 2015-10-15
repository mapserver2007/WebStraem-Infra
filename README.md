# README
## setup

### ssh-keygen
```sh
$> ssh-keygen -t rsa
```
* ファイルパスは`~/.ssh/id_rsa_vagrant_webstream_test`

### vagrant側へ公開鍵転送
```sh
$> ssh-copy-id -i ~/.ssh/id_rsa_vagrant_webstream_test.pub 192.168.0.206
```
  * Macにはコマンドがないので、githubから取ってくる

```sh
$> curl -L https://raw.githubusercontent.com/beautifulcode/ssh-copy-id-for-OSX/master/install.sh | sh
```

### ansible.cfg
* `$HOME/.ansible.cfg`

```vim
[defaults]
host_key_checking = False
```
  * 接続元ホストのチェックをしないようにする

### vagrant
```sh
$> vagrant up
$> vagrant provision
```

### ssh login
```sh
$> vagrant ssh-config --host 192.168.0.206 >> ~/.ssh/config
$> ssh 192.168.0.206
```
