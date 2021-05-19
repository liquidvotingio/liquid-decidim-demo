FROM ruby:2.7.1

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV RAILS_ENV production
ENV SECRET_KEY_BASE=no_need_for_such_secrecy
ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_LOG_TO_STDOUT true

RUN apt-get install -y git imagemagick wget \
  && apt-get clean
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && apt-get install -y nodejs \
  && apt-get clean
RUN npm install -g npm@6.3.0
RUN gem install bundler --version '>= 2.1.4'

WORKDIR /app

COPY . .

RUN bundle install
RUN bundle exec rails assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]

ENTRYPOINT []