FROM ruby:2.6

COPY Gemfile /Gemfile
COPY Gemfile.lock /Gemfile.lock

RUN bundle install

COPY Rakefile /Rakefile
COPY /config /config
COPY /db /db

RUN apt-get update
RUN apt-get -y install nodejs

COPY . /

RUN bundle exec rails db:migrate
RUN bundle exec rake db:setup

EXPOSE 3000

CMD ["rails", "s", "-b", "0.0.0.0"]
