FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx openssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=MO/L=Khouribga/O=42/OU=42/CN=motelti.42.fr"

COPY conf/default /etc/nginx/sites-available/default

CMD ["nginx", "-g", "daemon off;"]
