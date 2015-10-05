#!/bin/bash

echo "run script for unix or linux"


function killnginx(){
	ps aux | grep nginx| while  read L
	do
		eval $(echo $L | awk -F " " '{print "tmp="$2 ; }' );
	    if [ $tmp -lt $$ ]; then
	    	echo "kill nginx on pid = $tmp "
	    	kill -9 $tmp
	    fi
	done
}

function killpython(){
	ps aux | grep python| while  read L
	do
		eval $(echo $L | awk -F " " '{print "tmp="$2 ; }' );
	    if [ $tmp -lt $$ ]; then
	    	echo "kill nginx on pid = $tmp "
	    	kill -9 $tmp
	    fi
	done

}

function helpinfo(){
	echo "运行 run.sh 使用下面的参数:"
    echo "stop   ---> 杀死之前进程，清理"
    echo "test   ---> 测试nginx配置文件"
    echo "start  ---> 杀死之前进程，清理，重新启动nginx 和 wsgiapp"
    echo "reload ---> 重新加载nginx 配置文件"
    echo "举个栗子: ./run.sh start "

}


if [[ $# == 0 ]]; then
	helpinfo
elif   [[ $1 == "startA" ]]; then
	echo "start python app and nginx"
	killnginx
	killpython
	sudo nginx -c /Users/x/server/conf/nginx.conf  &
	(cd ./web
    #/usr/local/bin/gunicorn --bind 127.0.0.1:9000 --workers 4 --worker-class gevent wsgiapp:application & 
	python wsgiapp.py &
		)
elif   [[ $1 == "startN" ]]; then
	echo "start nginx"
	sudo nginx -c /Users/x/server/conf/nginx.conf  &
elif   [[ $1 == "startP" ]]; then
	echo "start python app"
	(cd ./web
    #/usr/local/bin/gunicorn --bind 127.0.0.1:9000 --workers 4 --worker-class gevent wsgiapp:application & 
	python wsgiapp.py &
		)

elif [[ $1 == "stopA" ]]; then
	echo "stop python and ngix"
	killnginx
	killpython
elif [[ $1 == "stopN" ]]; then
	echo "stop nginx"
	killnginx
elif [[ $1 == "stopP" ]]; then
	echo "stop python"
	killpython

elif [[ $1 == "reload" ]]; then
	echo "reload"
	sudo nginx -s reload -c /Users/x/server/conf/nginx.conf
elif [[ $1 == "test" ]]; then
	echo "test"
	sudo nginx -t -c /Users/x/server/conf/nginx.conf
elif [[ $1 == "help" ]]; then
    helpinfo
else 
	echo "wrong para"
fi