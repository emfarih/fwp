# Use the official Nginx image from the Docker Hub
FROM nginx:alpine

# Remove the default Nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy your custom Nginx configuration file into the container
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the built Flutter web app to the Nginx web directory
COPY build/web /usr/share/nginx/html

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
