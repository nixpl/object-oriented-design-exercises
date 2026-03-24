FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y fpc --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY main.pas /app/

RUN fpc main.pas -oBubbleSort

CMD ["./BubbleSort"]