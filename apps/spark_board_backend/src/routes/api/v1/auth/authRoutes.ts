import { Router } from "express";
import { validator } from "../../../../middlewares/reqValidator";
import { good } from "../../../../utils/response";
import { tryCatch } from "../../../../utils/tryCatch";
import { SignupBody, signupSchema } from "./authSchema";

/**
 * "/api/v1/auth" route.
 */
const auth = Router();

// /api/v1/auth/signup
auth.post(
  "/signup",
  validator(signupSchema),
  tryCatch<SignupBody>(async (req, res) => {
    // TODO: create user
    res.json(good({ message: "User created successfully" }));
  })
);

export { auth as authRoute };
