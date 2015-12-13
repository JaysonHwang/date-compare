#!/bin/sh
# author JaysonHwang
# date 2015-12-06
ST=$(date +%s) #program start time
DATELIMIT=$1
LTtotal=0 #number that less than date limit
GTtotal=0 #number that greater than date limit
EQtotal=0 #number that equal as date limit
TOTAL=0   #total number
#这2个变量都不能为空，否则输出提示
if [[ x$DATELIMIT == x ]]
then
        echo -e "usage:\n       ./date_compare.sh DATELIMIT [<FILE]"
        echo "DATELIMIT: [YYYYMMDD|YYYY-MM-DD]"
        echo "FILE: file that include paths to other files;or just left blank for stdin"
        exit
fi
#重定向输出文件
exec 3<>result_lt_$DATELIMIT.txt;
exec 4<>result_gt_$DATELIMIT.txt;
exec 5<>result_eq_$DATELIMIT.txt;
#输出结果集合
while read line<&0;
do
    dateline=`stat -c %x $line|cut -d ' ' -f 1`;
    dateline2s=$(date +%s -d $dateline);
    LIMIT2s=$(date +%s -d $DATELIMIT);
    d=$((dateline2s-LIMIT2s));
        if [[ d -lt 0 ]]
    then
        echo "$dateline $line">&3
        LTtotal=$((LTtotal+1))
        TOTAL=$((TOTAL+1))
    elif [[ d -gt 0 ]]
    then
        echo "$dateline $line">&4
        GTtotal=$((GTtotal+1))
        TOTAL=$((TOTAL+1))
    elif [[ d -eq 0 ]]
    then
        echo "$dateline $line">&5
        EQtotal=$((EQtotal+1))
        TOTAL=$((TOTAL+1))
    fi
done
ET=$(date +%s) #program end time
#输出统计结果
echo "<<<<<<<< $DATELIMIT  lt:$LTtotal  total:$TOTAL  time:$((ET-ST))s">&3
echo ">>>>>>>> $DATELIMIT  gt:$GTtotal  total:$TOTAL  time:$((ET-ST))s">&4
echo "======== $DATELIMIT  eq:$EQtotal  total:$TOTAL  time:$((ET-ST))s">&5
echo "results stored in 3 files: result_[lt|eq|gt]_[YYYYMMDD|YYYY-MM-DD].txt">&1
echo "lt:$LTtotal  eq:$EQtotal  gt:$GTtotal  total:$TOTAL  time:$((ET-ST))s">&1
exec 3>&-
exec 3<&-
exec 4>&-
exec 4<&-
exec 5>&-
exec 5<&-
exit
