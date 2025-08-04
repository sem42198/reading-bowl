FROM ruby:3.0-bullseye as base

RUN apt-get update -qq && apt-get install -y build-essential apt-utils libpq-dev nodejs

WORKDIR /docker/app

RUN gem install bundler

COPY Gemfile* ./

#RUN bundle update
RUN bundle install

ADD . /docker/apps

#CMD [ "bundle","exec", "puma", "config.ru"]
# you can also write like this.
CMD ["rails","server","-b","0.0.0.0"]