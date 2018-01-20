#!/bin/bash

clear
#pwd
#export -p
#echo $PATH
#echo $HOME  
#PWD=$(pwd)
#echo $PWD

echo "debug result text: (1=yes or 0=not)"
read -n 1 int_debug
echo 
#if [ $int_debug == 1 ]; then
    #echo "debugs"
#fi  

if [ $(whoami) != "root" ]; then
    echo "Not, User is root!"
    exit 1
fi

echo "Debian Update System (1=yes or 0 = not)"
read -n 1 int_checkupdate
echo
if [ $int_checkupdate == 1 ]; then
    arr_apt_command=(autoclean update upgrade dist-upgrade autoremove)
    for i in ${arr_apt_command[@]}; do
        bin_apt="apt-get ${i}"
        if [ $int_debug == 1 ]; then
            echo "command: $bin_apt"
        else  
            echo `$bin_apt`
        fi
    done
fi 

echo "Install Programs (1=yes or 0=not)"
read -n 1 int_checkprograms
echo 
if [ $int_checkprograms == 1 ]; then
    arr_programs=(wget make gawk gcc bc syslinux genisoimage build-essential)
    for i in ${arr_programs[@]}; do
        echo "install ${i}?(y/n)"
        read -n 1 ch_check
        echo 
        if [ "$ch_check" == "y" ]; then 
            bin_apt_install="apt-get install ${i}"
            if [ $int_debug == 1 ]; then
                echo "command: $bin_apt_install"
            else  
                echo `$bin_apt_install`
            fi
        fi
    done
fi

echo "Install Web Server (1=yes or 0=not)"
read -n 1 int_checkwebserver
echo 
if [ $int_checkwebserver == 1 ]; then
    source mysql.txt
    source php7.0.txt
    source apache2.txt
fi

exit 0