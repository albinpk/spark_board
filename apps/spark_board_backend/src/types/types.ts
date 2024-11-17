import { NextFunction, Request, Response } from "express";

/**
 * Type for common express request.
 * Used for add type to request body.
 */
interface Req<T> extends Request {
  body: T;
}

/**
 *  Type for express request handler.
 */
export type ReqHandler<T = any> = (
  req: Req<T>,
  res: Response,
  next: NextFunction
) => Promise<any>;
