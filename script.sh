#!/bin/sh
path=$(ls -A '/minecrafts')
if [ -z "$path" ]
then
    cd minecraft
    screen -dmS new_screen bash
    screen -S new_screen -p 0 -X exec java -Xmx1024M -Xms1024M -jar server.jar nogui
    sleep 15
    ps aux | grep "SCREEN" | awk '{print $2}'| sed 1q |xargs kill
    cd ..
    cp -r /minecraft/* /minecrafts/
fi
authtoken="$1"
echo "${authtoken}" > authtoken
chmod +x authtoken
cd minecrafts
screen -dmS new_screen bash
screen -S new_screen -p 0 -X exec java -Xmx1024M -Xms1024M -jar server.jar nogui
cd ..
./ngrok authtoken "$authtoken"
./ngrok tcp 25565 --region in --log=stdout > ngrok.log &
sleep 2
bash -c "cat ngrok.log | grep -Po '(?<=(url=tcp://)).*(?=)' > ngrok_data.txt "
bash -c 'cat ngrok_data.txt;bash'
