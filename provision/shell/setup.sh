#!/bin/bash

env

sudo sysctl -w fs.file-max=524288
sudo sysctl -p

shmmax="268435456"

sudo su -
if grep -q "kernel\.shmmax" "/etc/sysctl.conf"; then
  sed -i "s/\(kernel\.shmmax\).*\$/\1 = ${shmmax}/" /etc/sysctl.conf
else
  echo kernel.shmmax = ${shmmax} >> /etc/sysctl.conf
fi

sysctl -p

exit