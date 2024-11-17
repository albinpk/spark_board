import { Router } from "express";
import { createUser, loginUser } from "../../../../controllers/authController";
import { validator } from "../../../../middlewares/reqValidator";
import { good } from "../../../../utils/response";
import { tryCatch } from "../../../../utils/tryCatch";
import { LoginBody, loginSchema, SignupBody, signupSchema } from "./authSchema";

/**
 * "/api/v1/auth" route.
 */
const auth = Router();

// /api/v1/auth/signup
auth.post(
  "/signup",
  validator(signupSchema),
  tryCatch<SignupBody>(async (req, res) => {
    const createdUser = await createUser(req.body);
    res.json(
      good({
        message: "User created successfully",
        data: createdUser,
      })
    );
  })
);

/**
 * @swagger
 * /v1/auth/login:
 *   post:
 *     summary: User login
 *     tags: [auth]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email:
 *                 type: string
 *                 default: albin@mail.com
 *               password:
 *                 type: string
 *                 default: 12345678
 *     responses:
 *       200:
 *         description: API response
 */
auth.post(
  "/login",
  validator(loginSchema),
  tryCatch<LoginBody>(async (req, res) => {
    const user = await loginUser(req.body);
    res.json(
      good({
        message: "Logged in successfully",
        data: user,
      })
    );
  })
);

export { auth as authRoute };
