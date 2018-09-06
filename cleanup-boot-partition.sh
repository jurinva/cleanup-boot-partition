#!/bin/bash

function Uclean() {
  version=''
  for I in `sudo dpkg --list 'linux-image*'|awk '{ if ($1=="ii") print $2}'|grep -v 'uname -r' | grep -v extra`; do
    kernel=`echo $I | cut -d"-" -f3`
    kversion=`echo $I | cut -d'-' -f4`
    if [ $version != '' ]; then version=`echo "$version,$kversion"`
      else version=`echo $kversion`
    fi
  done
  sudo rm -rf /boot/*-$kernel-{$version}-*
  sudo apt-get -f install
  sudo apt-get autoremove
  sudo update-grub
  sudo apt-get update
}

if [ `cat /etc/issue.net | cut -d' ' -f1` == 'Ubuntu' ]; then
  Uclean
fi
