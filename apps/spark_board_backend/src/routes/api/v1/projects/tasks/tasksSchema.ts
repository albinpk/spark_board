import Joi from "joi";

/**
 * Request body for creating a task.
 */
export interface CreateTaskBody {
  name: string;
  description?: string;
  status?: string;
}

/**
 * Joi schema for create task request body.
 */
export const createTaskSchema = Joi.object<CreateTaskBody>({
  name: Joi.string().required(),
  description: Joi.string().allow(null),
  status: Joi.string().allow(null).valid("todo", "inProgress", "done"),
});

/**
 * Request body for updating a task.
 */
export interface UpdateTaskBody {
  name?: string;
  description?: string;
  status?: string;
}

/**
 * Joi schema for update task request body.
 */
export const updateTaskSchema = Joi.object<UpdateTaskBody>()
  .min(1)
  .required()
  .keys({
    name: Joi.string().allow(null),
    description: Joi.string().allow(null),
    status: Joi.string().allow(null).valid("todo", "inProgress", "done"),
  });
