#!/usr/bin/bash
#
# Code by: hk22
# System: Unix
# Date: 06/07/2022 as 16:58 p.m
# Requirements: index.html page, wget
#####################################

function email_collect() {
         cat index.html |grep "@" |tr -d "[:blank:]" |grep -i ".com" \
                        |sed 's/<!--//g' |sed 's/-->//g' \
                        |sed 's/<metaname="reply-to"content="//g' |sed 's/">//g'
}

read -t 12 -p "[-] Enter FULL url: " url;echo

if [[ $url != "" ]];then
    echo "[-] Checking URL ..."; sleep 1
    code=$(curl -s -o /dev/null -w "%{http_code}" -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" $url)

    if [[ $code == "200" ]];then
        echo "[+] Starting Download"; sleep 1; echo
        wget $url -U "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" -O index.html -nv

    if [[ $(echo $?) == "0" ]];then
        echo
        echo "[+] Download Done!"; sleep 1
        echo "[+] Collecting e-mails"; sleep 1
        email_collect #function call
    else
        echo "[x] Download Failed"; sleep 1
        exit 1
    fi
    fi
else
    echo "[x] Not Found"; sleep 1
fi
