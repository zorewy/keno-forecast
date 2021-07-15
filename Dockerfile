# Dockerfile 1
FROM node:14
WORKDIR /app
COPY . /app

# 设置时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

#CMD npm run prd-dev && npx pm2 log #一定要是阻塞控制台的程序
