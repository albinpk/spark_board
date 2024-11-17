import Joi from "joi";

/** Signup request body. */
export interface SignupBody {
  name: string;
  email: string;
  password: string;
}

/** Joi schema for signup request body. */
export const signupSchema = Joi.object<SignupBody>({
  name: Joi.string().required(),
  email: Joi.string().email().required(),
  password: Joi.string().min(6).required(),
});

/** Login request body. */
export interface LoginBody {
  email: string;
  password: string;
}

/** Joi schema for login request body. */
export const loginSchema = Joi.object<LoginBody>({
  email: Joi.string().email().required(),
  password: Joi.string().required(),
});
