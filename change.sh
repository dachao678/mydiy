#bin/bash!
UA_Browser="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.87 Safari/537.36"
LOG_FILE="check.log";
input=y
while [[ "$input" == "y" ]]
do
    result=$(curl --user-agent "${UA_Browser}" -fsL --write-out %{http_code} --output /dev/null --max-time 10 "https://www.netflix.com/title/70143836" 2>&1)
    if [[ "$result" == "404" ]];then
        echo -e "IP掉了切换中"&& echo -e " IP掉了切换中: $(date)" >> ${LOG_FILE};
        systemctl restart wg-quick@wgcf
        sleep 3
	
    elif  [[ "$result" == "403" ]];then
        echo -e "IP掉了切换中"&& echo -e " IP掉了切换中: $(date)" >> ${LOG_FILE};
        systemctl restart wg-quick@wgcf
        sleep 3
	
    elif  [[ "$result" == "200" ]];then
            echo -e "IP OK!"&& echo -e " IP OK!: $(date)" >> ${LOG_FILE};
            sleep 1200

    elif  [[ "$result" == "000" ]];then
	echo -e "IP掉了切换中"&& echo -e " IP掉了切换中: $(date)" >> ${LOG_FILE};
        systemctl restart wg-quick@wgcf
    fi
done
