# Trang tĩnh: chỉ cần nginx phục vụ index.html + assets
FROM nginx:1.27-alpine
# PAGE chọn bản trang: index.html (gốc) hoặc green/index.html
ARG PAGE=index.html
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY ${PAGE} /usr/share/nginx/html/index.html
COPY assets /usr/share/nginx/html/assets
EXPOSE 80
