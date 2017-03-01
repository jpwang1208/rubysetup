#!/bin/bash

########################################
# EDIT this section to Select Versions #
########################################

RUBY_VSERION="ruby-2.4.0"

########################################

#安装rvm,ruby环境需要使用rvm安装
setup_rvm(){

	rvm -v
    if [ "$?" -eq 0 ]; then
	    echo "rvm is installed!"
    else
	    echo "install rvm ..."
	    curl -L https://get.rvm.io | bash -s stable

	    #在当前Termal载入rvm环境,如果重新打开Termal就不需要了
	    source ~/.rvm/scripts/rvm
    fi	
}

#ruby version list
function ruby_version_list()
{
	rl='rvm list known'
	echo $rl
}

#安装指定的ruby
setup_ruby(){  
    
    echo "ruby rvm ..."
    num=`rvm install "${RUBY_VSERION}" | grep one | wc -l `
 
    if [[ $num -ge "$Already" ]]; then
      	 echo "Already installed ruby [$RUBY_VSERION]"
    	 #先移除指定的版本 
         #rvm remove 2.4.0
         #重新安装版本 
         #rvm reinstall ruby-2.4.0         
    fi  

    #使用发布版ruby
    /bin/bash --login
    #设置默认版本，如果安装了有可能不是默认版本
    rvm use RUBY_VSERION --default
    echo "ruby is installed"
}

#安装cocoapods
setup_cocoapads(){

	echo "install cocoapods ..."
	osversion=`sw_vers -productVersion`
    lowerversion="10.11"

	if [ `expr $osversion \> $lowerversion` -eq 0 ];then
       sudo gem install cocoapods
    else   
       sudo gem install -n /usr/local/bin cocoapods
    fi

    podversion=`pod --version`
    echo -e "\033[31mcocoapods version:[$podversion] \033[0m"
    echo "cocoapods installed"
} 

#安装rails
setup_rails(){

	echo "install rails ..."
    #安装rails
	sudo gem install rails --remote
    #安装sqlite3
	sudo gem install sqlite3 --remote
	echo "rails installed"
}

#更新ruby源
change_rubysources()
{
	echo "change ruby sources to ruby-china"
	#添加ruby-china 源
    gem sources --remove https://rubygems.org/
    gem sources --add https://gems.ruby-china.org
}
#卸载rvm
#rvm implode
#检查rvm版本,如果未安装则安装
setup_rvm
#ruby
setup_ruby
#更改国内源
echo "hhhhhhhhhhhhhh"
change_rubysources
#cocoapods
setup_cocoapads
#rails
setup_rails
