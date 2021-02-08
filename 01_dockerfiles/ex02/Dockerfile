#
# Create demo app following rails official tutorial :
#	https://guides.rubyonrails.org/getting_started.html
# Use a ruby container mounting current directory to do so :
#	$>docker-machine mount [MACHINE_NAME]:"$(pwd)"
#	$>docker run -it --rm --name ruby-forge --mount type=bind,source=[VM_PATH_TO_CURRENT_DIR],target=/app -p 3000:3000 ruby:latest /bin/bash
# Once the app is created, build the 'ONBUILD' Dockerfile :
#	$>docker build -t ft-rails:on-build - < Dockerfile
# Then build the provided Dockerfile in app directory's root :
# $>docker build -t [IMAGE_TAG_NAME] -f [NAME_OF_PROVIDED_DOCKERFILE] .
# Finally run with :
#	docker run --rm --name [CONTAINER_NAME] -p 3000:3000 [IMAGE_TAG_NAME]
#
FROM ruby:latest

ONBUILD COPY . /opt/app
ONBUILD WORKDIR /opt/app

ONBUILD RUN bundle install --jobs 20
