# Trang tĩnh: chỉ cần nginx phục vụ index.html + assets
FROM nginx:1.27-alpine
ARG PAGE=index.html
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY ${PAGE} /usr/share/nginx/html/index.html
COPY assets /usr/share/nginx/html/assets
EXPOSE 80
