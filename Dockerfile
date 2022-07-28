FROM node:14-alpine as builder

WORKDIR /app

COPY package*.json ./

RUN ["npm","install"]

COPY . .

RUN ["npm","run","build"]






# FROM bitnami/nginx:latest

# WORKDIR /opt/bitnami/nginx/html

# COPY default.conf /opt/bitnami/nginx/conf/server_blocks/my_server_block.conf

# COPY --from=builder /app/build ./

# COPY entrypoint.sh ./

# ENTRYPOINT [ "/bin/bash" ]
# CMD ["./entrypoint.sh"]



FROM nginx:1.13.5


WORKDIR /usr/share/nginx/html

COPY default.conf /etc/nginx/nginx.conf

COPY --from=builder /app/build ./

COPY entrypoint.sh ./

RUN usermod --non-unique --uid 1000 nginx \
  && groupmod --non-unique --gid 1000 nginx \
  && chown -R nginx:nginx /usr/share/nginx/html

ENTRYPOINT [ "/bin/bash" ]
CMD ["./entrypoint.sh"]