import Joi from "joi";
import { appError } from "../models/appError";
import { ReqHandler } from "../types/types";

/**
 * Middleware to validate request body.
 * @param schema Joi schema
 * @returns request handler
 */
export const validator: (schema: Joi.ObjectSchema) => ReqHandler = (schema) => {
  return async (req, res, next) => {
    const { error } = schema.validate(req.body);
    if (error) return next(appError(error.message, 400));
    next();
  };
};
