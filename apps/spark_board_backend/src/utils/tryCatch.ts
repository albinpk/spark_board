import { NextFunction, Request, Response } from "express";

type Handler = (
  req: Request,
  res: Response,
  next: NextFunction
) => Promise<any>;

/**
 * A wrapper for async request handlers to catch errors.
 * @param handler express request handler
 */
export const tryCatch: (handler: Handler) => Handler =
  (handler) => async (req, res, next) => {
    try {
      await handler(req, res, next);
    } catch (error) {
      next(error);
    }
  };
