FROM nginx:alpine

# Copy your static website into nginx
COPY website/ /usr/share/nginx/html

# Expose port 80
EXPOSE 80
