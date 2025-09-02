#!/bin/bash
# install.sh
# Script to set up a Minecraft Forge 1.20.1 server on a fresh Linux install

set -e

FORGE_VERSION="1.20.1-47.2.0"
INSTALLER="forge-${FORGE_VERSION}-installer.jar"
FORGE_JAR="forge-${FORGE_VERSION}-server.jar"
SERVER_DIR="$HOME/forge-1.20.1"

echo "--- Updating system and installing Java 17 ---"
sudo apt update
sudo apt install -y openjdk-17-jre-headless wget

echo "--- Creating server directory at $SERVER_DIR ---"
mkdir -p "$SERVER_DIR"
cd "$SERVER_DIR"

echo "--- Downloading Forge installer ($FORGE_VERSION) ---"
wget -O "$INSTALLER" "https://maven.minecraftforge.net/net/minecraftforge/forge/${FORGE_VERSION}/${INSTALLER}"

echo "--- Running Forge installer (server mode) ---"
java -jar "$INSTALLER" --installServer

echo "--- Accepting EULA ---"
echo "eula=true" > eula.txt

echo "--- Creating start.sh script ---"
cat > start.sh <<EOL
#!/bin/bash
java -Xmx4G -Xms2G -jar $FORGE_JAR nogui
EOL
chmod +x start.sh

echo "--- Forge server installed! ---"
echo "To start your server, run:"
echo "  cd $SERVER_DIR && ./start.sh"
