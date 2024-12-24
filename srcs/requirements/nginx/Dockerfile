# Use the official Nginx image from the Docker Hub
FROM nginx:latest



# Copy custom configuration file from the host to the container
COPY /requirements/nginx/tools/nginx.conf /etc/nginx/nginx.conf
COPY /requirements/nginx/tools/default.conf /etc/nginx/conf.d/default.conf
COPY /requirements/nginx/tools/certs /etc/nginx/certs
# Copy the init-letsencrypt.sh file from the host to the container
#COPY /requirements/nginx/tools/init-letsencrypt.sh /usr/local/bin/init-letsencrypt.sh
#RUN chmod +x /usr/local/bin/init-letsencrypt.sh

#RUN echo "0 3 * * * root certbot renew --quiet && nginx -s reload" >> /etc/cron.d/certbot-renew
#RUN chmod +x /etc/cron.d/certbot-renew && crontab /etc/cron.d/certbot-renew



# Expose port 80 to the host
EXPOSE 443

# Start Nginx when the container has started
# CMD ["/bin/bash", "-c", "/usr/local/bin/init-letsencrypt.sh && cron && nginx -g", "daemon off;"]
CMD ["nginx", "-g", "daemon off;"]