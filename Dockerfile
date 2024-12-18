# Stage 1: flutter build
FROM debian:bullseye-slim AS flutter-build

WORKDIR /app

RUN apt-get update && apt-get install -y \
    curl \
    bash \
    git \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install fvm
RUN curl -fsSL https://fvm.app/install.sh | bash

RUN fvm --version

COPY apps/spark_board_frontend .

RUN fvm install -s
RUN fvm flutter pub get
RUN fvm flutter build web --release --dart-define=BASE_URL=https://spark-board.albinpk.dev/api

# Stage 2: Node.js build
FROM node:23.0.0

WORKDIR /usr/src/app

COPY apps/spark_board_backend/package.json .
COPY apps/spark_board_backend/package-lock.json .

RUN npm install

COPY apps/spark_board_backend .

COPY --from=flutter-build app/build/web public

RUN npm run build

CMD ["npm", "start"]
