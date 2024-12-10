import postgres from "postgres";

const sql = postgres({
  host: process.env.POSTGRES_HOST,
  port: process.env.POSTGRES_PORT as number | undefined,
  database: process.env.POSTGRES_DB,
  username: process.env.POSTGRES_USER_NAME,
  password: process.env.POSTGRES_PASSWORD,
});

export default sql;
