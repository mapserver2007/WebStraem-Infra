# infrastructure

Create a development environment of WebStream on Vagrant.

Need to install:
* VirtualBox
* Vagrant
* Ansible

## initial setting
Using [ansible_local](https://www.vagrantup.com/docs/provisioning/ansible_local.html) for provisioning, so you are [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest) install to your local machine.
```
$> vagrant plugin install vagrant-vbguest
```

## build
This environment is build for Dockerfile.  
Get the Dockerfile from `https://github.com/webstream-framework/Build.git` and execute command `docker build`.  
Otherwise, Get the Docker image from `https://hub.docker.com/u/webstream/` and build.  

## test
This environment is unit test and integration test for WebStream.  
The unit test is to use `PHPUnit`. The integration test also use `PHPUnit`, using the docker container when http access and database access is required.  
This testing environment is the same as the testing on the cloud CI environment (ex: [TravisCI](https://travis-ci.org/))

## License
Licensed under the MIT
http://www.opensource.org/licenses/mit-license.php
