echo "Starting Minecraft server.  To view window type screen -r minecraft."
echo "To minimize the window and let the server run in the background, press Ctrl+A then Ctrl+D"
cd /home/ubuntu/MCServer
/usr/bin/screen -dmS minecraft /usr/bin/java -jar -Xms2500M -Xmx2500M -Dcom.mojang.eula.agree=true /home/ubuntu/MCServer/paperclip.jar
