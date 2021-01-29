# Build with :
#	$> docker build --build-arg HOST_ADDRESS="$(docker-machine ip master)" -t gitlab .
# Run with :
#	$>docker run -d --restart=on-failure --privileged --name gitlab -p 8080:80 -p 8022:22 -p 8443:443 gitlab
# Follow container execution with :
#	$> docker logs -f gitlab
# To push/pull from repository :
# Create repository from gitlab web interface then :
# For ssh :
# - Add public key to desired user from gitlab web interface and clone with :
#	$> git clone ssh://git@[SERVER_IP]:8022/[USER]/[REPOSITORY_NAME]
# For https, clone with :
#	$> git -c http.sslVerify=false clone https://[SERVER_IP]:8443/[USER]/[REPOSITORY_NAME]

FROM debian

# Will contain host's ip, passed from command line at build
ARG HOST_ADDRESS

# Install gitlab-ce
RUN apt-get update && apt-get install -y curl openssh-server ca-certificates perl
RUN curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash
RUN apt-get install -y gitlab-ce

# Setup self-signed certificate for https access
RUN echo "external_url 'https://${HOST_ADDRESS}'" > /etc/gitlab/gitlab.rb
RUN mkdir -p /etc/gitlab/ssl && chmod 700 /etc/gitlab/ssl
RUN openssl req -nodes -newkey rsa:2048 -keyout etc/gitlab/ssl/${HOST_ADDRESS}.key -out /etc/gitlab/ssl/${HOST_ADDRESS}.csr -subj '/CN=/O=/C='
RUN openssl x509 -req -days 365 -in /etc/gitlab/ssl/${HOST_ADDRESS}.csr -signkey /etc/gitlab/ssl/${HOST_ADDRESS}.key -out /etc/gitlab/ssl/${HOST_ADDRESS}.crt
RUN rm -v /etc/gitlab/ssl/${HOST_ADDRESS}.csr
RUN chmod 600 /etc/gitlab/ssl/${HOST_ADDRESS}.*

ENTRYPOINT (/opt/gitlab/embedded/bin/runsvdir-start &) && gitlab-ctl reconfigure && service ssh restart && tail -f /dev/null
