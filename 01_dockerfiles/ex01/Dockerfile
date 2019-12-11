# docker build -t myts . && docker run -it --rm -e TS3SERVER_LICENSE=accept -p 9987:9987/udp -p 10011:10011 myts
FROM debian:latest
# 9987 default voice
# 10011 server query
# 30033 file transport
EXPOSE 9987/udp 10011 30033
RUN apt-get update \
&& apt-get install -y wget bzip2 \
&& cd /home \
&& wget https://files.teamspeak-services.com/releases/server/3.10.2/teamspeak3-server_linux_amd64-3.10.2.tar.bz2 \
#&& wget http://dl.4players.de/ts/releases/3.2.0/teamspeak3-server_linux_amd64-3.2.0.tar.bz2 \
&& tar xfvj teamspeak3-server_linux_amd64-3.10.2.tar.bz2 \
&& touch /home/teamspeak3-server_linux_amd64/.ts3server_license_accepted

ENV TS3SERVER_LICENSE=accept

WORKDIR /home/teamspeak3-server_linux_amd64

CMD ["sh", "ts3server_minimal_runscript.sh"]
