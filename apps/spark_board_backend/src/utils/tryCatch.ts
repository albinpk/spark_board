import { ReqHandler } from "../types/types";

/**
 * A wrapper for async request handlers to catch errors.
 * @param handler express request handler
 */
export function tryCatch<T = any>(handler: ReqHandler<T>): ReqHandler {
  return async (req, res, next) => {
    try {
      await handler(req, res, next);
    } catch (error) {
      next(error);
    }
  };
}
