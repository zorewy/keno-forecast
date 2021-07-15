# 设置基础镜像
#FROM node:14
# 定义作者aaa
FROM nginx
MAINTAINER wk

#RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone
#
#RUN npm set registry https://registry.npm.taobao.org
#RUN npm install
#CMD npm run build



## 将dist文件中的内容复制到 /usr/share/nginx/html/ 这个目录下面
COPY dist/  /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/nginx.conf
RUN echo 'echo init ok!!'
