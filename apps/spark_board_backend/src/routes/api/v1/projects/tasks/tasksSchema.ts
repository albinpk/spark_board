import Joi from "joi";

/**
 * Request body for creating a task.
 */
export interface CreateTaskBody {
  name: string;
  description?: string;
}

/**
 * Joi schema for create task request body.
 */
export const createTaskSchema = Joi.object<CreateTaskBody>({
  name: Joi.string().required(),
  description: Joi.string().allow(null),
});
