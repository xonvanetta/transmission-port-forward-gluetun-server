FROM ruby:2.5-alpine

WORKDIR /usr/src/app

COPY . .

VOLUME [ "/config" ]

CMD ["ruby", "./qbt_port_forwarder.rb"]