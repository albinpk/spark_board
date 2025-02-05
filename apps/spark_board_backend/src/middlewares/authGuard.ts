import { ReqHandler } from "../types/types";
import { verifyToken } from "../utils/jwt";
import { bad } from "../utils/response";

// only this works https://stackoverflow.com/a/71126179/22350396
declare module "express-serve-static-core" {
  export interface Request {
    userId: string;
  }
}

/**
 * Middleware to verify auth token.
 * @param req express request
 * @param res express response
 * @param next express next
 */
export const authGuard: ReqHandler = async (req, res, next) => {
  try {
    const token = req.headers.authorization?.split(" ")[1];
    if (!token) {
      return res.status(401).json(bad({ message: "Please login" }));
    }
    try {
      const { userId } = verifyToken(token);
      req.userId = userId!;
      next();
    } catch (error) {
      return res.status(401).json(bad({ message: "Please login" }));
    }
  } catch (error) {
    next(error);
  }
};
