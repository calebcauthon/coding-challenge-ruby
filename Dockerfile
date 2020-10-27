FROM ruby:2.6

RUN apt-get update
RUN apt-get -y install nodejs

COPY Gemfile /Gemfile
COPY Gemfile.lock /Gemfile.lock

RUN bundle install

COPY Rakefile /Rakefile
COPY /config /config
COPY /db /db
COPY /bin /bin
COPY /app /app

RUN bundle exec rails db:migrate
RUN bundle exec rake db:setup

EXPOSE 3000

COPY . /

CMD ["rails", "s", "-b", "0.0.0.0"]
