#!/usr/bin/env bash
CYAN='\033[0;36m'
GREEN='\033[1;32m'
RED='\033[0;31m'
NC='\033[0m'

declare -a jars
echo -e  ${CYAN}have a nice day : $(date "+%F %R")${NC}
export EUREKA_CLIENT_SERVICEURL_DEFAULTZONE=http://172.20.239.11:9091/service-registry/eureka
export SPRING_PROFILES_ACTIVE=dev
#read -e -p "enter your jar file name:" jar_file
BASE_DIR=`dirname $0`
#	if [[ -z $DB_USR  ]]
#	then
#	read -p "enter your Database username : " db_usr
#	echo -e "DB_USR=\"${db_usr}\"" >> /etc/environment
#	export DB_USR=$db_usr
#	fi
#	if [[ -z $DB_PASS  ]]
#	then
#	read -p "enter your Database password : " db_pass
#	echo -e "DB_PASS=\"${db_pass}\"" >> /etc/environment
#	export DB_PASS=$db_pass
#	fi
	#export SPRING_DATASOURCE_HIKARI_USERNAME=$DB_USR
	#export SPRING_DATASOURCE_HIKARI_PASSWORD=$DB_PASS
	#export SPRING_DATASOURCE_USERNAME=$DB_USR
	#export SPRING_DATASOURCE_PASSWORD=$DB_PASS

	jars=$(find ${BASE_DIR} -maxdepth 1 -iname "*.jar" )
	
	echo "press corresponding digit to start the jar"
	declare -i i=0
	for jar in ${jars[@]};do
		jars[i]=$(echo $jar | rev | cut -d'/' -f 1 | rev)
		printf $i"	";echo $jar | rev | cut -d'/' -f 1 | rev
		((i=i+1))
	done
if [[ ${#jars[@]} -ne 0 ]]
then
	read -p "which one do you want to execute(type integer) :" jar_index
	jar_file_name=$(echo ${jars[jar_index]})
	jar_file_name_kill=$(echo $jar_file_name | cut -d'-' -f 1)
	echo -e "$CYAN you chose : ${jar_file_name} \n remember last version and new jar file version must be same to this script run properly$NC"
JAR_LOC="${BASE_DIR}/${jar_file_name}"
echo $JAR_LOC
nohup_output=`echo ${jar_file_name}  |cut -d'-' -f 1`
HUP_LOC="${BASE_DIR}/${nohup_output}"
if pgrep -f ${jar_file_name_kill} > /dev/null
then
	PID_JAR=`pgrep -f ${jar_file_name_kill}`
	kill -9 $PID_JAR
	test -f ${HUP_LOC}.out && rm -f ${HUP_LOC}.out
	nohup java -jar -Dspring.profiles.active=dev -Djava.net.preferIPv4Stack=true -Djava.net.preferIPv4Addresses $JAR_LOC > /log/${nohup_output}.out 2>&1 &
	echo -e "${GREEN}${jar_file}	previous process killed and new process executed${NC}"
else
	nohup java -jar -Dspring.profiles.active=dev -Djava.net.preferIPv4Stack=true -Djava.net.preferIPv4Addresses $JAR_LOC > /log/${nohup_output}.out 2>&1 &
	echo -e "${GREEN}${jar_file}	just new process executed${NC}"
fi
else
	echo -e "${RED}jar file doesn't exist on shell directory${NC}"
fi
