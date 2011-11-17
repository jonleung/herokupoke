#Settings
PERIOD_IN_SECONDS=120 #How often do you want to check that your websites are up?
SECONDS_TO_WAIT_UNTIL_TRY_UNREACHABLE_SITE_AGAIN=4 #When your site cannot be reached, how long do you want to wait before you try reaching it again?
NUMBER_OF_TIMES_TO_TRY_TO_REACH_UNREACHABLE_SITE_BEFORE_CALLING=3 #How many times do you want to try getting to your website before you get a call?
MAXIMUM_RATE_OF_CALLS_IN_SECONDS=3600 #What is the maximum rate that you would recieve a call? Default = 1hr 3600 seconds

#Twilio Information
MP3_FILE_URL="http://dl.dropbox.com/u/49019009/server_down.mp3"
PHONE_TO_CALL_WHEN_SERVER_IS_DOWN="555-555-5555"

ACCOUNTSID="ACc458a..." #Find this here: https://www.twilio.com/user/account
AUTHTOKEN="eee53145.." #Find this here: https://www.twilio.com/user/account
CALLERID="999-999-9999" #Make sure you register for one here: https://www.twilio.com/user/account/phone-numbers/incoming

#We're using the API described here: http://labs.twilio.com/bash/index

#Settings END

echo
DOWN_COUNT=0
UP=0
LAST_CALL_TIME=132150778

function poke_once {
	if curl $1 2> /dev/null | grep -q -i "html"; then
		UP=0
	else
		UP=-1
	fi
}

function poke {

	DOWN_COUNT=0
	poke_once $1
	if [ $UP -eq 0 ]
		then
		echo "	" UP $1
	fi

	while [ $UP -eq -1 ]
	do
		echo DOWN $1
		echo -en "\007"

		let "DOWN_COUNT+=1"

		if [ $DOWN_COUNT -eq $NUMBER_OF_TIMES_TO_TRY_TO_REACH_UNREACHABLE_SITE_BEFORE_CALLING ]
			then
			CURTIME=$(date +%s)
			let DELTA=CURTIME-LAST_CALL_TIME
			if [ "$DELTA" -gt "$MAXIMUM_RATE_OF_CALLS_IN_SECONDS" ]
				then
				echo calling you...
				echo "$MP3_FILE_URL" | ./twilio_call -d "$CALLERID" -u "$ACCOUNTSID" -p "$AUTHTOKEN" "$PHONE_TO_CALL_WHEN_SERVER_IS_DOWN"
				LAST_CALL_TIME=CURTIME
				DOWN_COUNT=0
			fi
			break
		fi
		sleep $SECONDS_TO_WAIT_UNTIL_TRY_UNREACHABLE_SITE_AGAIN
		poke_once $1
	done
}

while :
do
	date
	poke "cis195.com"
	poke "jonathanjl.com"
	poke "slidefeed.com"
	poke "slidephone.heroku.com"
	poke "hackertrails.com"
	poke "thebokchoy.com"
	poke "uponstage.org"
	poke "awo378ehiwo93arf8.com"

	sleep $PERIOD_IN_SECONDS

	echo
done