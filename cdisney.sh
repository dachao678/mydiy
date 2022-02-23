#bin/bash!
UA_Browser="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.87 Safari/537.36"
PreAssertion=$(curl --user-agent "${UA_Browser}" -s --max-time 5 -X POST "https://global.edge.bamgrid.com/devices" -H "authorization: Bearer ZGlzbmV5JmJyb3dzZXImMS4wLjA.Cu56AgSfBTDag5NiRA81oLHkDZfu5L3CKadnefEAY84" -H "content-type: application/json; charset=UTF-8" -d '{"deviceFamily":"browser","applicationRuntime":"chrome","deviceProfile":"windows","attributes":{}}' 2>&1)
assertion=$(echo $PreAssertion | python -m json.tool 2> /dev/null | grep assertion | cut -f4 -d'"')
PreDisneyCookie=$(curl -s --max-time 10 "https://raw.githubusercontent.com/lmc999/RegionRestrictionCheck/main/cookies" | sed -n '1p')
disneycookie=$(echo $PreDisneyCookie | sed "s/DISNEYASSERTION/${assertion}/g")
TokenContent=$(curl --user-agent "${UA_Browser}" -s --max-time 5 -X POST "https://global.edge.bamgrid.com/token" -H "authorization: Bearer ZGlzbmV5JmJyb3dzZXImMS4wLjA.Cu56AgSfBTDag5NiRA81oLHkDZfu5L3CKadnefEAY84" -d "$disneycookie")

fakecontent=$(curl -s --max-time 10 "https://raw.githubusercontent.com/lmc999/RegionRestrictionCheck/main/cookies" | sed -n '8p')
refreshToken=$(echo $TokenContent | python -m json.tool 2> /dev/null | grep 'refresh_token' | awk '{print $2}' | cut -f2 -d'"')
disneycontent=$(echo $fakecontent | sed "s/ILOVEDISNEY/${refreshToken}/g")
tmpresult=$(curl --user-agent "${UA_Browser}" -X POST -sSL --max-time 5 "https://disney.api.edge.bamgrid.com/graph/v1/device/graphql" -H "authorization: ZGlzbmV5JmJyb3dzZXImMS4wLjA.Cu56AgSfBTDag5NiRA81oLHkDZfu5L3CKadnefEAY84" -d "$disneycontent" 2>&1)
region=$(echo $tmpresult | python -m json.tool 2> /dev/null | grep 'countryCode' | cut -f4 -d'"')


echo -n -e "$PreAssertion 换行 /n/n $assertion （坏了）换行 /n/n $PreDisneyCookie 换行 /n/n $disneycookie换行 /n/n $TokenContent （坏了）换行 /n/n $fakecontent 换行 /n/n  $refreshToken （坏了）换行/n/n $disneycontent 换行 /n/n  $tmpresult，，换行，$region "
