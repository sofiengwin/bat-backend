FROM ruby:2.7.6
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install --without development test

# Add a script to be executed every time the container starts.
COPY ./entrypoints/ /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
RUN chmod +x /usr/bin/sidekiq-entrypoint.sh
COPY . /myapp
EXPOSE 3000
ENTRYPOINT ["docker-entrypoint.sh"]
