# 设置基础镜像
FROM nginx
# 定义作者
MAINTAINER wk
# 将dist文件中的内容复制到 /usr/share/nginx/html/ 这个目录下面
COPY index.css  /usr/local/nginx/html/
COPY index.html  /usr/local/nginx/html/
COPY index.js  /usr/local/nginx/html/
COPY images/  /usr/local/nginx/html/
#COPY nginx.conf /etc/nginx/nginx.conf
RUN echo 'echo init ok!!'
