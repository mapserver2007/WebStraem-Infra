#!/bin/sh

VM_PASS="vagrant"

expect -c "
set timeout 1
spawn ssh webstream-test
expect \"Are you sure you want to continue connecting (yes/no)?\" {
    send send \"yes\n\"
}
expect \"vagrant@192.168.0.205's password:\" {
    send \"${VM_PASS}\n\"
    send \"/usr/bin/mysql -u mysql -pmysql sandbox < webstream-test-table.sql\n\"
    send \"exit\n\"
}
"