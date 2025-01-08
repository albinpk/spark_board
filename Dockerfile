FROM node:23.0.0

WORKDIR /usr/src/app

COPY apps/spark_board_backend/package.json .
COPY apps/spark_board_backend/package-lock.json .

RUN npm install

COPY apps/spark_board_backend .

COPY apps/spark_board_frontend/build/web public

RUN npm run build

CMD ["npm", "start"]

