import { Router } from "express";
import { authGuard } from "../../../middlewares/authGuard";
import { good } from "../../../utils/response";
import { tryCatch } from "../../../utils/tryCatch";
import { authRoute } from "./auth/authRoutes";
import { usersRoute } from "./users/usersRoute";

/**
 * "/api/v1" route.
 */
const v1 = Router();

// /api/v1/
v1.all(
  "/",
  tryCatch(async (_, res) => res.json(good({ message: "v1 API" })))
);

// /api/v1/auth
v1.use("/auth", authRoute);

// /api/v1/users
v1.use("/users", authGuard, usersRoute);

export { v1 as v1Route };
