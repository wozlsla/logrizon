# Step 1: Flutter 빌드
FROM ghcr.io/cirruslabs/flutter:3.29.2 AS builder

WORKDIR /app
COPY . .

RUN flutter precache --web

RUN flutter pub get
RUN flutter build web

# Step 2: Nginx로 정적 배포
FROM nginx:alpine

COPY --from=builder /app/build/web /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]