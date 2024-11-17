import Joi from "joi";
import { ReqHandler } from "../types/types";
import { bad } from "../utils/response";

/**
 * Middleware to validate request body.
 * @param schema Joi schema
 * @returns request handler
 */
export const validator: (schema: Joi.ObjectSchema) => ReqHandler = (schema) => {
  return async (req, res, next) => {
    const { error } = schema.validate(req.body);
    if (error) {
      return res.status(400).json(bad({ message: error.message }));
    }
    next();
  };
};
