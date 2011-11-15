count_sheep () {
	sleep 100
}

function poke {
	if curl $1 2> /dev/null | grep -q -i "html"; then
    	echo OK $1
    	count_sheep
    else
    	echo -en "\007"
    	poke $1
	fi
}

while :
do
	poke "jonathanjl.com"
	poke "cis195.com"
	poke "slidefeed.com"
	poke "slidephone.heroku.com"
	poke "hackertrails.com"
	poke "thebokchoy.com"
	poke "uponstage.org"
done
