#!/bin/bash
#auther: sunday
#Date: 2018-06-27

HOST="localhost"
PORT="80"
STATUS="nginx_status"
[ $# -ne 1 ] && echo "Usage:(active|reading|writing|waiting|accpets|handled|requests)"

#检测nginx进程是否存在
function ping {
    /sbin/pidof nginx | wc -l
    }
# 检测nginx性能
function active {
    /usr/bin/curl "http://$HOST:$PORT/$STATUS/" 2>/dev/null| grep 'Active' | awk '{print $NF}'
    }
function reading {
    /usr/bin/curl "http://$HOST:$PORT/$STATUS/" 2>/dev/null| grep 'Reading'| awk '{print $2}'
    }
function writing {
    /usr/bin/curl "http://$HOST:$PORT/$STATUS/" 2>/dev/null| grep 'Writing'| awk '{print $4}'
    }
function waiting {
    /usr/bin/curl "http://$HOST:$PORT/$STATUS/" 2>/dev/null| grep 'Waiting'| awk '{print $6}'
    }
function accepts {
    /usr/bin/curl "http://$HOST:$PORT/$STATUS/" 2>/dev/null| awk NR==3 | awk '{print $1}'
    }
function handled {
    /usr/bin/curl "http://$HOST:$PORT/$STATUS/" 2>/dev/null| awk NR==3 | awk '{print $2}'
    }
function requests {
    /usr/bin/curl "http://$HOST:$PORT/$STATUS/" 2>/dev/null| awk NR==3 | awk '{print $3}'
    }
#执行function
$1
