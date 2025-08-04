FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY 502.html /usr/share/nginx/html/502.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]