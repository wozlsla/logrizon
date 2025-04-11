# Flutter 웹 정적 파일만 서빙하는 nginx 컨테이너
FROM nginx:alpine

# Flutter에서 빌드한 웹 정적 파일 복사
COPY build/web /usr/share/nginx/html

# 포트 노출  (내부 컨테이너용)
EXPOSE 80

# nginx 실행 (기본 포그라운드 실행)
CMD ["nginx", "-g", "daemon off;"]