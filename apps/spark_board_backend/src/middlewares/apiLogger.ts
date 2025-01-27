import { ReqHandler } from "../types/types";

/**
 * Middleware to log request details.
 * @param req express request
 * @param res express response
 * @param next express next
 */
export const logHandler: ReqHandler = async (req, res, next) => {
  console.log(req.method, req.url);
  next();
};
