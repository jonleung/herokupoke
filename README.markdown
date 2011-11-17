HerokuPoke will curl your list of websites every so often and give you a call if it cannot each your site. This just so happens that by curling a heroku hosted site will keep the process alive (otherwise if no one visits your site for some time, it will take too many seconds to load)

Instructions:
  cd in to the directory that heroku-poke.sh is contained in.
    
    cd directory_where_heroku-poke_is_located
    chmod 775 twilio-call
    chmod +x heroku-poke.sh

  Then make sure configure all the settings inside of heroku-poke.
  You can but do not need to modify the Heroku Poke settings, but you do need to enter in the Twilio information, namely:
  
    MP3_FILE_URL="http://dl.dropbox.com/u/49019009/server_down.mp3"
    PHONE_TO_CALL_WHEN_SERVER_IS_DOWN="555-555-5555"

    ACCOUNTSID="ACc458a..." #Find this here: https://www.twilio.com/user/account
    AUTHTOKEN="eee53145.." #Find this here: https://www.twilio.com/user/account
    CALLERID="999-999-9999" #Make sure you register for one here: https://www.twilio.com/user/account/phone-numbers/incoming
  
Note that we are assuming that your site is alive if we grep the curl of your site and find HTML in it.
