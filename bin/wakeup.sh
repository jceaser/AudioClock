#!/bin/bash

randstr()
{
	cont=true	
	while [ $cont == true ]
	do

		n=$((($RANDOM % $#) +1))
		
		exists=`grep ^${n}$ /usr/local/var/saytrain/burned.log`
		
#		echo ${n} exists=${exists} and is ${#exists} long. $cont
		if [ ${#exists} -eq 0 ]; then
#	 		echo "$n is unique"
			eval _RETVAL=\${$n}
	
			echo $n >> /usr/local/var/saytrain/burned.log
			logTail=`cat /usr/local/var/saytrain/burned.log | tail`
			echo "${logTail}" > /usr/local/var/saytrain/burned.log
			cont=false
		fi
 	
	done
}

now=`date +%l:%M`
today=`date +%Y\-%m\-%d`

holiday=`grep ^${today} /usr/local/etc/saytrain | cut -b 12-`

if [ "$holiday" != "" ] ; then
	echo Today is \"$holiday\", no train.
	exit
fi

s0="The time is $now."
s1="The time is $now."
s2="The time is $now."
s3="The time is $now."
s4="The time is $now."
s5="The time is $now."
s6="The time is $now."
s7="The time is $now."
s8="The time is $now."
s9="$now."
s10="It's $now, time to get up."
s11="It's $now, time to get up."
s12="It's $now, time to get up."
s13="It's $now, time to get up."
s14="It's $now, time to get up."
s15="It's $now, time to get up."
s16="It's $now, time to get up."
s17="It's $now, time to get up."
s18="It's $now, time to get up."
s19="$now"
s20="$now"

randstr "$s1" "$s2" "$s3" "$s4" "$s5" "$s6" "$s7" "$s8" "$s9" "$s10" "$s11" "$s12" "$s13" "$s14" "$s15" "$s16" "$s17" "$s18" "$s19" "$s20"

#echo say \"$_RETVAL\" | osascript
#say $_RETVAL

cacheFile=/usr/local/var/saytrain/`/sbin/md5 -q -s "$_RETVAL"`.acc

if [ ! -f $cacheFile ] ; then
	echo creating $cacheFile with:
	echo "$_RETVAL"
	say -o $cacheFile "$_RETVAL"
fi

afplay $cacheFile
touch $cacheFile

find /usr/local/var/saytrain/*.acc -depth 1 -mtime +30d -exec rm -f {} \;