FROM ruby:2.7.6
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
# must match versions in Gemfile
RUN gem install --no-document \
  puma:4.3.12 \
  nokogiri:1.13.10 \
  rails_admin:2.2.0 \
  rails:6.1.4

WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY ./entrypoints/ /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
RUN chmod +x /usr/bin/sidekiq-entrypoint.sh
COPY . /myapp
EXPOSE 3000
ENTRYPOINT ["docker-entrypoint.sh"]
