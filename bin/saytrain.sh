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

s0="It is time to leave for the train.  Go now or you will die a horrible death."

s1="Quick, the train is getting away.  You must leave now if your to catch it."
s2="It is time to leave for the train.  Click your heals three times and say \
there is no place like the train, their is no place like the train, there is \
no place like the train."
s3="The train is where you want to be.  Kiss the dog goodbye and fly."
s4="It's $now, you should leave now."
s5="You must leave now so that I can have the house all to myself"
s6="Scooby dobe do, where are you, I bet your at the train."
s7="It's $now, do you know where your train is?"
s8="I think your suppose to go somewhere, but I have forgotten where."
s9="I know what would be fun, catching the train."
s10="It's only $now, stay home with me and we will browse the web together."
s11="It's $now, why are you still here?"
s12="The time is now $now."
s13="I think the humans are gone puppy, now we can have our fun!"
s14="$now is the time."
s15="Good afternoon, gentlemen. I am a HAL 9000 computer"
s16="I've just picked up a fault in the AE-35 unit."
s17="It is not $now, you have plenty of time, don't worry about your schedule."
s18="The time is $now."
s19="Here puppy puppy puppy"
s20="Hurry up and leave or you will be late - $now."

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