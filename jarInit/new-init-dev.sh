#!/bin/bash
CYAN='\033[0;36m'
GREEN='\033[1;32m'
RED='\033[0;31m'
NC='\033[0m'

function getProperties() {
  declare -n associativeArray="$1"
  file=/etc/jinit.conf
  while IFS='|' read -r key value; do
    associativeArray[$key]=$value
  done <"$file"
}

while getopts ':v' optname; do
  case $optname in
  v)
    echo -e "${GREEN}@author sadeq${NC}"
    echo -e "${GREEN}@version 1.0.2${NC}"
    exit 0
    ;;
  *)
    echo -e "${RED}unknown option${NC}"
    exit 5
    ;;
  esac
done

declare -A map
getProperties map

declare -a jars
echo -e "${CYAN}time : $(date "+%F %R")${NC}"

for key in "${!map[@]}"; do
  printf '%s=%s\n' "$key" "${map["$key"]}"
  if [ "$key" == "eureka" ]; then
    export EUREKA_CLIENT_SERVICEURL_DEFAULTZONE="${map["$key"]}"
  fi
  if [ "$key" == "profile" ]; then
    export SPRING_PROFILES_ACTIVE="${map["$key"]}"
  fi
  if [ "$key" == "logpath" ]; then
    export LogPath="${map["$key"]}"
  fi
done

#read -e -p "enter your jar file name:" jar_file
#BASE_DIR=`dirname $0`
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

jars=($(find "$PWD" -maxdepth 1 -iname "*.jar"))
if [[ ${#jars[@]} -ne 0 ]]; then
  echo "press corresponding digit to start the jar"
  declare -i i=0
  for jar in "${jars[@]}"; do
    #jars[i]=$(echo $jar | rev | cut -d'/' -f 1 | rev)
    printf '%s    ' "$i"
    echo "$jar" | rev | cut -d'/' -f 1 | rev
    ((i = i + 1))
  done

  read -p "which one do you want to execute(type integer) :" jar_index
  jar_file_name=$(echo ${jars[jar_index]})
  {
    printf '%s---%s---%s\n' "$(date "+%F %R")" "$(who -m)" "$jar_file_name" &>>/var/log/jinit
  } 2>/dev/null
  jar_file_name_kill=$(echo "$jar_file_name" | rev | cut -d'/' -f 1 | rev | cut -d'-' -f 1)
  echo -e "$CYAN you chose : ${jar_file_name} $NC"
  JAR_LOC="${jar_file_name}"
  echo "$JAR_LOC"
  #nohup_output=`echo ${jar_file_name}  |cut -d'-' -f 1`
  #HUP_LOC="${BASE_DIR}/${nohup_output}"
  if pgrep -f "${jar_file_name_kill}" >/dev/null; then
    PID_JAR=$(pgrep -f "${jar_file_name_kill}")
    kill -9 "$PID_JAR"
    #test -f ${HUP_LOC}.out && rm -f ${HUP_LOC}.out
    nohup java -jar -Djava.net.preferIPv4Stack=true -Djava.net.preferIPv4Addresses "$JAR_LOC" >"${LogPath:-/log/}${jar_file_name_kill}".out 2>&1 &
    echo -e "${GREEN} ${jar_file_name} previous process killed and new process executed${NC}"
  else
    nohup java -jar -Djava.net.preferIPv4Stack=true -Djava.net.preferIPv4Addresses "$JAR_LOC" >"${LogPath:-/log/}${jar_file_name_kill}".out 2>&1 &
    echo -e "${GREEN} ${jar_file_name} just new process executed${NC}"
  fi
else
  echo -e "${RED}jar file doesn't exist on your current working directory${NC}"
fi
