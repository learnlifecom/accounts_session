FROM ruby:3.0.0-alpine

RUN apk add --update --no-cache bash \
    build-base \
    less \
    git

RUN gem install bundler

WORKDIR /app

COPY . .

RUN bundle install --no-cache --retry 3 --jobs 4 --path vendor/bundle

CMD ["cat"]
