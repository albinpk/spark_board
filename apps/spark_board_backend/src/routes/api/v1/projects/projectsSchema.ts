import Joi from "joi";

/**
 * Create project request body.
 */
export interface CreateProjectBody {
  name: string;
  description?: string;
}

/**
 * Joi schema for create project request body.
 */
export const createProjectSchema = Joi.object<CreateProjectBody>({
  name: Joi.string().required(),
  description: Joi.string().allow(null),
});
