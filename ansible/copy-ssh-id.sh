#!/usr/bin/bash
for ip in 192.168.56.10 192.168.56.21 192.168.56.22
  do
   ssh-copy-id vagrant@"$ip"
  done