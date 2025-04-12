# 베이스 이미지
FROM python:3.11-slim

# 작업 디렉토리 생성
WORKDIR /app

# 시스템 패키지 설치 (예: curl 등)
RUN apt-get update && apt-get install -y curl git && rm -rf /var/lib/apt/lists/*

# Poetry 설치
ENV POETRY_VERSION=2.1.2
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:$PATH"

# pyproject.toml 복사 및 의존성 설치
COPY pyproject.toml poetry.lock ./
RUN poetry config virtualenvs.create false && poetry install --no-interaction --no-ansi

# 코드 복사
COPY . .

# 포트 오픈
EXPOSE 8000

# 기본 명령
CMD ["poetry", "run", "mkdocs", "serve", "--dev-addr=0.0.0.0:8000"]
