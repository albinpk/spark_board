import { Router } from "express";
import { loginUser, signupUser } from "../../../../controllers/authController";
import { validator } from "../../../../middlewares/reqValidator";
import { good } from "../../../../utils/response";
import { tryCatch } from "../../../../utils/tryCatch";
import { LoginBody, loginSchema, SignupBody, signupSchema } from "./authSchema";

/**
 * "/api/v1/auth" route.
 */
const auth = Router();

// api/v1/auth/signup
auth.post(
  "/signup",
  validator(signupSchema),
  tryCatch<SignupBody>(async (req, res) => {
    const data = await signupUser(req.body);
    res.json(
      good({
        message: "Signed up successfully",
        data: data,
      })
    );
  })
);

// api/v1/auth/login
auth.post(
  "/login",
  validator(loginSchema),
  tryCatch<LoginBody>(async (req, res) => {
    const data = await loginUser(req.body);
    res.json(
      good({
        message: "Logged in successfully",
        data,
      })
    );
  })
);

export { auth as authRoute };
