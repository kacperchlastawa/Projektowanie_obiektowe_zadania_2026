FROM debian:stable-slim

RUN apt-get update && apt-get install -y fpc

WORKDIR /app

COPY program.pas .

RUN fpc program.pas

CMD ["./program"]