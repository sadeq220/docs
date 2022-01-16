#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[1;32m'
YELLOW='\e[1;33m'
BLUE='\e[1;34m'

function readUserName() {
	declare -n ref="$1"
while IFS=\= read -r key value ;do
		if [ ${key##*-} != 'portal' ] ;then
			break
		fi
		ref[${key%-*}]=$value
	done < <(grep -v '^#' sockets)
}

declare -A userMap
readUserName userMap

portal_url_dev=$( curl -s -m 10 -w "--%{HTTP_CODE}" --location --request POST 'portal4dev.privateDomain.ir/portal46/v1/tickets' --header ': ' --header 'Content-Type: application/x-www-form-urlencoded' --data-urlencode "username=${userMap[dev-username]}" --data-urlencode "password=${userMap[dev-pass]}" | tee .output |grep -oP action\=\".*?\" | grep -oP \".*?\" |grep -oE '[^\"]*')

if [ $? -ne 0 ] ;then
	echo -e "${RED}something wrong with portal-dev${NC}"
fi

if grep '\-\-401' .output >/dev/null ;then
	echo -e "${RED} dev portal user or pass is incorrect ${NC}"
fi

portal_url_test=$( curl -s -m 10 -w "--%{HTTP_CODE}" --location --request POST 'portal4t.privateDomain.ir/portal/v1/tickets' --header ': ' --header 'Content-Type: application/x-www-form-urlencoded' --data-urlencode "username=${userMap[test-username]}" --data-urlencode "password=${userMap[test-pass]}" | tee .output |grep -oP action\=\".*?\" | grep -oP \".*?\" |grep -oE '[^\"]*')

if [ $? -ne 0 ] ;then
	echo -e "${RED}something wrong with portal-test${NC}"
fi

if grep '\-\-401' .output >/dev/null ;then
	echo -e "${RED} test portal user or pass is incorrect ${NC}"
fi

portal_url_prod=$( curl -s -m 10 -w "--%{HTTP_CODE}" --location --request POST 'portal.privateDomain.ir/portal/v1/tickets' --header ': ' --header 'Content-Type: application/x-www-form-urlencoded' --data-urlencode "username=${userMap[prod-username]}" --data-urlencode "password=${userMap[prod-pass]}" | tee .output |grep -oP action\=\".*?\" | grep -oP \".*?\" |grep -oE '[^\"]*')

if [ $? -ne 0 ] ;then
	echo -e "${RED} something wrong with portal-prod ${NC}"
fi

if grep '\-\-401' .output >/dev/null ;then
	echo -e "${RED} prod portal user or pass is incorrect ${NC}"
fi

ticket_dev=$(curl -s --location --request POST "$portal_url_dev" --header 'Content-Type: application/x-www-form-urlencoded' --data-urlencode 'service=https://gw4dev.privateDomain.ir:443/ticket_check')

ticket_test=$(curl -s --location --request POST "$portal_url_test" --header 'Content-Type: application/x-www-form-urlencoded' --data-urlencode 'service=https://gw4t.privateDomain.ir:443/ticket_check')

ticket_prod=$(curl -s --location --request POST "$portal_url_prod" --header 'Content-Type: application/x-www-form-urlencoded' --data-urlencode 'service=https://gw.privateDomain.ir:443/ticket_check')

fs_ticket="%-17s${YELLOW}%s${NC}\n"
printf "$fs_ticket" 'dev-tocken' "$ticket_dev"
printf "$fs_ticket" 'test-tocken' "$ticket_test"
printf "$fs_ticket" 'prod-tocken' "$ticket_prod"

fss="%-17s%-7s%-12s%-7s\n"
printf "${BLUE}${fss}${NC}" 'micro-name' 's' 'status_code' 'total_time(s)'
while IFS=\= read -r key value ;do
	if [ ${key#*-} == 'dev' ] ;then
		ticket=$ticket_dev
	elif [ ${key##*-} == 'portal' ] ;then
		continue
	elif [ ${key#*-} == 'prod' ] ;then
		ticket=$ticket_prod
	elif [ ${key#*-} == 'test' ] ;then
		ticket=$ticket_test
	else
		echo -e "${RED}undefined key  $key"
		exit 10
	fi
	Json_result=$(curl -s -m 5 -w "|%{HTTP_CODE}|%{TIME_TOTAL}" "${value}/actuator/health?ticket=${ticket}")
		
	HTTP_code=$(echo "$Json_result" | cut -d'|' -f2)
	TOTAL_time=$(echo "$Json_result" | cut -d'|' -f3)
	if echo $Json_result | grep UP >/dev/null ;then
		printf "${GREEN}${fss}${NC}" "$key" ok "${HTTP_code}" "${TOTAL_time}"
	else
		printf "${RED}${fss}${NC}" "$key" notok "${HTTP_code}" "${TOTAL_time}"
	fi
done < <(grep -v '^#' sockets)

read -p 'press Enter to exit' ok

