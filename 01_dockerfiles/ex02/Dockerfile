# Run with `docker build -t myrails . ; docker build -t myapp -f Dockerfile-son . ; docker run -it --rm -p 3000:3000 myapp`
FROM ruby:latest

RUN apt-get update && apt-get install -y sqlite3 npm
RUN npm install --global yarn
RUN mkdir -p /opt/app
RUN gem install rails bundler:2.0.2
ONBUILD COPY app/ /opt/app
ONBUILD WORKDIR /opt/app
ONBUILD RUN yarn install --check-files
ONBUILD RUN bundle update --bundler && bundle install
ONBUILD RUN rake db:migrate
ONBUILD RUN rake db:seed
