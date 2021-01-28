# Build with :
#	docker build -t ft-rails:on-build - < Dockerfile
# Then create app in exercise's folder root (ruby's app version must be 2.5.1)
# Then build from subject's provided Dockerfile with :
#	docker build -f [SUBJECT_DOCKERFILE] -t [IMAGE_TAG_NAME] .
# Finally run with :
#	docker run --rm --name [CONTAINER_NAME] -p 3000:3000 [IMAGE_TAG_NAME]
FROM ruby:2.5.1

RUN apt-get update && apt-get install -y nodejs
RUN gem install rails && gem install bundler

ONBUILD COPY . /opt/app
ONBUILD WORKDIR /opt/app

ONBUILD RUN bundle install --jobs 20

ONBUILD RUN rake db:migrate
ONBUILD RUN rake db:seed
