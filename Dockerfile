FROM ruby:2.5-alpine

WORKDIR /usr/src/app

COPY . .

VOLUME [ "/config" ]

RUN echo "*/10 * * * * ruby /usr/src/app/qbt_port_forwarder.rb" | crontab -

CMD ["/usr/src/app/entrypoint.sh"]