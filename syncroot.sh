#!/usr/bin/env bash
cd /root/git/nicksenv
git pull
chown -R nick:users root/home/nick
rsync -av --exclude syncroot.sh /root/git/nicksenv/root/ / 
