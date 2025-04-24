FROM python:3.11-slim

# 환경 변수 설정
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# 작업 디렉토리 설정
WORKDIR /usr/src/app

# Poetry 설치
RUN pip install --upgrade pip \
    && pip install poetry

# 프로젝트 파일 복사
COPY . /usr/src/app

# 의존성 설치
RUN poetry config virtualenvs.create false \
    && poetry install --no-root \
    && poetry add gunicorn

# RUN pip install -r requirements.txt
# ADD requirements.txt /usr/src/app/
# ADD . /usr/src/app/

# Run Django Server
# CMD ["poetry", "run", "python", "manage.py", "runserver", "0.0.0.0:8000"]

# Gunicorn으로 WSGI 실행 (config/wsgi.py 기준)
CMD ["poetry", "run", "gunicorn", "config.wsgi:application", "--bind", "0.0.0.0:8000"]