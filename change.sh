#bin/bash!
UA_Browser="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.87 Safari/537.36"

input=y
while [[ "$input" == "y" ]]
do
    result=$(curl --user-agent "${UA_Browser}" -fsL --write-out %{http_code} --output /dev/null --max-time 10 "https://www.netflix.com/title/70143836" 2>&1)
    if [[ "$result" != "200" ]];then
        echo -e "IP掉了切换中$(date)"
        systemctl restart wg-quick@wgcf
        sleep 3
    else 
            echo -e "IP OK!$(date)"
            sleep 300 
    fi
done
