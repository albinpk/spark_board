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
