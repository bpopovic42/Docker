#
# Build and run with :
# docker build -t c_env . && docker run --rm -it c_env
#

# 42 required VM version is 18:04
FROM ubuntu:18.04

# Install required dependencies for 42 C development + additional tools
RUN apt update \
	&& apt install -y --no-install-recommends \
	build-essential \
	clang-9 \
	cmake \
	curl \
	git \
	make \
	man-db \
	openssh-client \
	ruby \
	ruby-bundler \
	ruby-dev \
	sudo \
	vim \
	zsh

# Install 42 norminette
RUN git clone https://github.com/hivehelsinki/norminette-client.git /.norminette \
	&& cd /.norminette \
	&& bundle \
	&& chmod 755 norminette.rb \
	&& ln -s /.norminette/norminette.rb /usr/bin/norminette

# Replace gcc with clang-9
RUN rm /usr/bin/gcc \
	&& ln -s /usr/bin/clang-9 /usr/bin/gcc

# Username to be used for the container
ENV DOCKER_USER dev

# Add aforementioned user
# Don't use password since we run in a local environment
RUN adduser --disabled-password --gecos '' "$DOCKER_USER"
RUN adduser "$DOCKER_USER" sudo \
	&& echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Switch to our newly created user
USER "$DOCKER_USER"

# Install oh-my-zsh for our user
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN mkdir /home/$DOCKER_USER/devel
WORKDIR "/home/$DOCKER_USER/devel"

ENTRYPOINT zsh
