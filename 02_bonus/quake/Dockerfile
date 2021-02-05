#
# Build with :
#	$> docker build -t docker_quake .
# Run with :
#	$> docker run -it --name docker_quake -e QUSER="$(echo $USER)" -e SERVER="$(docker-machine ip [MACHINE_NAME])" -e HTTP_PORT=8080 -p 8080:80 -p 27960:27960 docker_quake
#
# Once the game is running, you can open the console with '~'
# To add bots from this console, first gain admin rights using $PASS from
# server.cfg file :
# /rconpassword $PASS
# Then either add bots one by one (with the Major character for instance) :
# /rcon addbot major
# Or multiple bots at once (here 6) :
# /rcon bot_minplayers 6
#
# NOTES :
# Original QuakeJS server installation tutorial :
# https://steamforge.net/wiki/index.php/How_to_setup_a_local_QuakeJS_server_under_Debian_9_or_Debian_10#Setup_a_Local_QuakeJS_Server
# Quake 3 server administration resources :
# https://www.quake3world.com/q3guide/servers.html
#

from debian:latest

# Install required dependencies, including proper node version and clone the
# quakejs repository
RUN apt update && apt upgrade -y && apt install -y \
	curl -y \
	&& curl -sL https://deb.nodesource.com/setup_8.x | bash - \
	&& apt install -y \
	git \
	nodejs \
	npm \
	apache2 \
	jq \
	wget \
	&& git clone --recurse-submodules https://github.com/begleysm/quakejs.git

# Install quakejs
WORKDIR /quakejs
RUN npm install

# Import our own configuration file for the server
COPY server.cfg /quakejs/base/baseq3/server.cfg
# Fixed version removing manual EULA validation
COPY ioq3ded.fixed.js /quakejs/build/ioq3ded.js

# Replace default server files with quakejs ones
RUN rm /var/www/html/index.html \
	&& cp /quakejs/html/* /var/www/html/

WORKDIR /var/www/html
# Get game's assets from original content server ('content.quakejs.com')
# and redirect 'content.quakejs.com' to localhost, in order to use our own 
# content server instead of the original one
# (Must be done after getting assets from original content server !)
RUN bash get_assets.sh \
	&& echo "127.0.0.1 content.quakejs.com" >> /etc/hosts

WORKDIR /quakejs
ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
