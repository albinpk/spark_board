/**
 * Error class for global error handler.
 */
export class AppError extends Error {
  statusCode: number;

  constructor(message: string, statusCode: number) {
    super(message);
    this.statusCode = statusCode;
  }
}

/**
 * Create new AppError.
 * @param message api error message
 * @param statusCode api response status code
 * @returns AppError
 */
export const appError = (message: string, statusCode: number) =>
  new AppError(message, statusCode);
