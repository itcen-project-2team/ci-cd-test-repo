# Dockerfile (루트에 위치)
FROM nginx:alpine

# 정적 웹 파일 복사
COPY ./public /usr/share/nginx/html

# NGINX 설정 복사
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
