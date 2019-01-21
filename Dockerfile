FROM ruby:2.3.3

RUN apt-get update && apt-get install -y nodejs libpq-dev

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY Gemfile* /app/
WORKDIR /app

RUN bundle install

CMD ["rails", "s"]
