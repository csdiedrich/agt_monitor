#!/usr/bin/expect -f
spawn ssh-copy-id $argv
expect "password:"
send "$PWD_ROOT\n"
expect eof
