import { ReqHandler } from "../types/types";
import { bad } from "../utils/response";

/**
 * Invalid route handler for express.
 * @param req express request
 * @param res express response
 */
export const notFoundHandler: ReqHandler = async (req, res) => {
  res.status(404).json(bad({ message: "Route not found" }));
};
