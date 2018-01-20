#!/bin/bash
########################
### RoboMen          ###
### info@robomen.net ###
########################

clear
#pwd
#export -p
#echo $PATH
#echo $HOME  
#PWD=$(pwd)
#echo $PWD

echo -e -n " Debug result: (1=yes or 0=not)"
read -n 1 int_debug
echo 
#if [ $int_debug == 1 ]; then
    #echo "debugs"
#fi   
if [ $(whoami) != "root" ]; then
    echo "Not, User is root!"
	echo
    exit 1
fi

echo -e -n "Debian Update System (1=yes or 0=not)"
read -n 1 int_checkupdate
echo
if [ $int_checkupdate == 1 ]; then
	echo -e -n " Default reinstall source.list ftp.bg.debian.org (1=default or 0=not)"
	read -n 1 int_check
	echo 
	if [ $int_check == 1 ]; then
		cp /etc/apt/sources.list  /etc/apt/sources.list.bak
		cp sources.list.copy /etc/apt/sources.list
		echo
	fi
    arr_apt_command=(autoclean update upgrade dist-upgrade autoremove)
    for i in ${arr_apt_command[@]}; do
        bin_apt="apt-get ${i}"
        if [ $int_debug == 1 ]; then
            echo "command: $bin_apt"
        else  
            echo `$bin_apt`
			echo
        fi
    done
fi 
echo 
echo -e -n "Install Programs (1=yes or 0=not)"
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
				echo 
            else  
                echo `$bin_apt_install`
				echo 
            fi
        fi
		echo
    done
fi

echo
echo -e -n "Install Web Server (1=yes or 0=not)"
read -n 1 int_checkwebserver
echo 
if [ $int_checkwebserver == 1 ]; then
    source mysql.txt
	echo
    source php7.0.txt
	echo
    source apache2.txt
	echo
fi

exit 0
