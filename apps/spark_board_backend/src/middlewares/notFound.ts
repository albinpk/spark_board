import { Request, Response } from "express";
import { bad } from "../utils/response";

/**
 * Invalid route handler for express.
 * @param req express request
 * @param res express response
 */
export const notFoundHandler = (req: Request, res: Response) => {
  res.status(404).json(bad({ message: "Route not found" }));
};
