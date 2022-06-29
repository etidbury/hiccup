# Custom Hiccup

Ripped from: https://github.com/ashwin-pc/hiccup


## Usage

`docker-compose.yml` service:

```yml
 hiccup:
    image: public.ecr.aws/d9d2k9d8/hiccup:latest
    ports:
      - '8899:8899'
    environment:
      - CUSTOM_PORT=8899
      - CONFIG_JSON_REWRITE_DIR=https://MYBUCKET.s3.eu-west-2.amazonaws.com/hiccup/

```