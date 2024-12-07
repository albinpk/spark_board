import Joi from "joi";

/**
 * Create staff request body.
 */
export interface CreateStaffBody {
  name: string;
  email: string;
}

/**
 * Joi schema for create staff request body.
 */
export const createStaffSchema = Joi.object<CreateStaffBody>({
  name: Joi.string().required(),
  email: Joi.string().email().required(),
});

/**
 * Update staff request body.
 */
export interface UpdateStaffBody {
  name: string;
}

/**
 * Joi schema for update staff request body.
 */
export const updateStaffSchema = Joi.object<UpdateStaffBody>({
  name: Joi.string().required(),
});
