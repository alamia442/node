# Docker multi-stage build

# 1. Building the App with Maven
FROM node:lts-alpine
WORKDIR /app

# Just echo so we can see, if everything is there :)
RUN apk update \
	&& apk add --no-cache --update bash wget unzip tar \
	&& mkdir -p downloads frontweb \
	&& wget -q https://downloads.rclone.org/rclone-current-linux-amd64.zip \
	&& unzip -q rclone-current-linux-amd64.zip \
	&& wget -q https://github.com/P3TERX/aria2-builder/releases/download/1.35.0_2020.09.04/aria2-1.35.0-static-linux-amd64.tar.gz \
	&& tar xf aria2-1.35.0-static-linux-amd64.tar.gz \
	&& mv rclone-*-linux-amd64/rclone /usr/bin/ \
	&& mv aria2c /usr/local/bin/ \
	&& wget --no-check-certificate https://github.com/mayswind/AriaNg/releases/download/1.1.7/AriaNg-1.1.7.zip \
	&& unzip AriaNg-1.1.7.zip -d frontweb \
	&& rm -rf AriaNg-* rclone-* aria2-*

COPY . .
RUN npm install

ENV PORT=8080
EXPOSE 8080

CMD ["bash", "init.sh"]
