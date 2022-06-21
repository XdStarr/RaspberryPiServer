echo "Creating Minecraft Server for Raspberry Pi"

if [ -d "minecraft"]
then
  echo "Directory minecraft already exists!  Exiting... "
  exit 1
fi

date
echo "Downloading dependencies for Minecraft Server..."
sudo apt-get update
sudo apt-get install openjdk-11-jre-headless -y
sudo apt-get install screen -y

echo "Creating minecraft server directory..."
mkdir minecraft
cd minecraft

echo "Downloading 1.16.5 version of Minecraft..."
wget -O paperclip.jar https://papermc.io/api/v1/paper/1.19/latest/download

echo "Building the Minecraft server... "
java -jar -Xms800M -Xmx800M paperclip.jar

echo "Accepting the EULA... "
echo eula=true > eula.txt

echo "Grabbing start.sh from repository... "
wget -O start.sh https://raw.githubusercontent.com/mtoensing/RaspberryPiMinecraft/master/start.sh
chmod +x start.sh

echo "Oh wait. Checking for total memory available..."
TotalMemory=$(awk '/MemTotal/ { printf "%.0f\n", $2/1024 }' /proc/meminfo)
if [ $TotalMemory -lt 3000 ]; then
  echo "Sorry, have to grab low spec start.sh from repository... "
  wget -O start.sh https://raw.githubusercontent.com/mtoensing/RaspberryPiMinecraft/master/start_lowspec.sh
fi

echo "Grabbing restart.sh from repository... "
wget -O restart.sh https://raw.githubusercontent.com/mtoensing/RaspberryPiMinecraft/master/restart.sh
chmod +x restart.sh

echo "Enter a name for your server "
read -p 'Server Name: ' servername

echo "server-name=$servername" >> server.properties
echo "motd=$servername" >> server.properties

echo "view-distance=5" >> server.properties
echo "view-distance=5" >> spigot.yml

echo "Setup is complete. To run the server go to the minecraft directory and type ./start.sh"
echo "Don't forget to set up port forwarding on your router. The default port is 25565" 
