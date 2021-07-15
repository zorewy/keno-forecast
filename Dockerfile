# 设置基础镜像
FROM nginx
# 定义作者
MAINTAINER wk
# 将dist文件中的内容复制到 /usr/share/nginx/html/ 这个目录下面
COPY src/index.css  /usr/share/nginx/html/
COPY src/index.html  /usr/share/nginx/html/
COPY src/index.js  /usr/share/nginx/html/
COPY src/images  /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/nginx.conf
RUN echo 'echo init ok!!'
