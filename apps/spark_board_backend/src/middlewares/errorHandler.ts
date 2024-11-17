import { NextFunction, Request, Response } from "express";
import { bad } from "../utils/response";

/**
 * Global error handler for express.
 * @param err express error
 * @param req express request
 * @param res express response
 * @param next express next
 */
export const errorHandler = (
  err: any,
  req: Request,
  res: Response,
  next: NextFunction
) => {
  console.error(err.stack);
  res.status(500).json(bad({ message: err.message }));
};
