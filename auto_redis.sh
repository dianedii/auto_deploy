#!/bin/bash

#-------------------------------------------------------------------------------------------#
#---------------------------------------配置信息--------------------------------------------#
#-------------------------------------------------------------------------------------------#

#请准确配置以下信息

#redis所在（绝对）路径
redis_path="/opt/software"

#节点端口
node_port="6379"

#保存配置文件的目录 --可不修改
save_file_catalog="config"


#XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX#

#-------------------------------------------------------------------------------------------#
#-------------------------------！！！下方内容请勿修改！！！--------------------------------#
#-------------------------------------------------------------------------------------------#

#创建目录
cd ${redis_path}/


#编译安装redis
function compileRedis(){
	cd ${redis_path}
	tar -xvzf redis-4.0.6.tar.gz && cd redis-4.0.6
	
	if [ -e "${save_file_catalog}" ]
	then
		rm -rf ${save_file_catalog}
	fi
		mkdir ${save_file_catalog}
	if [ ! -f "src/redis-server" -o ! -f "src/redis-cli" ]
	then
		echo "The redis may not be compiled. Compile it first! Please wait a moment..."
		echo -e "\n\nComplie redis : $(date)\n" >> ${save_file_catalog}/compile.log
		make >> ${save_file_catalog}/compile.log 2>&1
		make install >> ${save_file_catalog}/compile.log 2>&1
		echo -e "Compile success!\n"
	fi
}



#修改redis数据节点配置文件
function modifyAndCreateRedisConfigFile(){
	echo "Beging to Create and Mmodify redis config file..."	

	cd ${redis_path}/redis-4.0.6
	#将原有redis.conf拷贝（slave_num+1)份
	if [ ! -e "redis.conf" ]
	then
		echo "redis.conf is not exist!"
		exit 1
	fi
	
	#修改公共配置
	lineNum=$(egrep "^bind" redis.conf | wc -l)
	if [ ${lineNum} -gt 0 ]
	then
		sed -i 's/^bind\( \|.\|[0-9]\)\+/bind 0.0.0.0/g' redis.conf				
	else
		echo "${lineNum}, into else"
		echo "bind 0.0.0.0" >> redis.conf
	fi
	sed -i 's/^protected-mode yes/protected-mode no/g' redis.conf	
	
	#配置端口
	cp redis.conf ${save_file_catalog}/redis_m.conf	
	sed -i "s/^port\( \|[0-9]\)\+/port ${node_port}/g" ${save_file_catalog}/redis_m.conf	

	echo -e "Config redis success!\n"
}


#创建启动文件
function createStartScrit(){
	echo "Begin to create start script..."
	
	cd ${redis_path}/redis-4.0.6
	cd ${save_file_catalog}
	echo "echo \"Begin to start Redis!\"" >> startRedis.sh
	echo "nohup redis-server redis_m.conf > redis_m.log  2>&1 &" >> startRedis.sh	
	echo "echo \"Start Redis Success!\"" >> startRedis.sh
	
	chmod 777 startRedis.sh
	
	echo -e "Create start script success!\n"
}


#创建停止文件
function createStopScrit(){
	echo "Begin to create stop script..."

	cd ${redis_path}/redis-4.0.6
	cd ${save_file_catalog}
	echo "echo \"Begin to stop Redis!\"" >> stopRedis.sh	
	echo 'pids=$(ps -ef | grep redis | cut -c 10-16)' >> stopRedis.sh
	echo 'pidArr=$(echo ${pids}|tr "\n", "\n")' >> stopRedis.sh
	echo 'for pid in ${pidArr}' >> stopRedis.sh
	echo 'do' >> stopRedis.sh
	echo '    ps -p ${pid} > /dev/null' >> stopRedis.sh
	echo '    if [ $? -eq 0 ]' >> stopRedis.sh
	echo '    then' >> stopRedis.sh
	echo '        kill -9 ${pid}' >> stopRedis.sh
	echo '    fi' >> stopRedis.sh
	echo 'done' >> stopRedis.sh
	echo "echo \"Stop Redis Success!\"" >> stopRedis.sh
	chmod 777 stopRedis.sh
	
	echo -e "Create stop script success!\n"
}


#调用以上函数，完成配置
compileRedis
modifyAndCreateRedisConfigFile
createStartScrit
createStopScrit

exit 0


