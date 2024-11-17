/**
 * Interface for environment variables.
 */
namespace NodeJS {
  interface ProcessEnv {
    PORT: number;
    POSTGRES_HOST: string;
    POSTGRES_PORT: number;
    POSTGRES_DB: string;
    POSTGRES_USER_NAME: string;
    POSTGRES_PASSWORD: string;
  }
}
