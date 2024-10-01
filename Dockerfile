FROM linuxserver/transmission:4.0.6

WORKDIR /app

COPY *.sh ./

RUN echo "*/10 * * * * /bin/sh /app/main.sh" | crontab -

ENTRYPOINT []

CMD ["/app/entrypoint.sh"]
