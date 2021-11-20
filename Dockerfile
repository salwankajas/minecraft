FROM ubuntu

MAINTAINER kajas

Run apt-get update \
 && apt-get install sudo -yq \
 && sudo apt update \
 && debian_frontend=noninteractive sudo apt install openjdk-17-jdk -yq  \
 && sudo apt install screen -yq \
 && mkdir minecraft \
 && cd minecraft \
 && apt-get install wget -yq \
 && wget https://launcher.mojang.com/v1/objects/a16d67e5807f57fc4e550299cf20226194497dc2/server.jar \
 && java -Xmx1024M -Xms1024M -jar server.jar nogui \
 && sed -i 's/eula=false/eula=true/g' eula.txt \
 && sed -i 's/online-mode=true/online-mode=false/g' server.properties \
 && cd .. \
 && apt-get install wget -yq \
 && wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip \
 && apt-get install unzip -yq \
 && unzip ngrok-stable-linux-amd64.zip

EXPOSE 25565

COPY script.sh .

ENTRYPOINT ["./script.sh"]
