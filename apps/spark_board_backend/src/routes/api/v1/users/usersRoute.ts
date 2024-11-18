import { Router } from "express";
import { getAllUsers } from "../../../../controllers/usersController";
import { good } from "../../../../utils/response";
import { tryCatch } from "../../../../utils/tryCatch";

/**
 * "/api/v1/users" route.
 */
const users = Router();

/**
 * @swagger
 * /v1/users:
 *   get:
 *     summary: User signup
 *     tags: [user]
 */
users.get(
  "/",
  tryCatch(async (req, res) => {
    const users = await getAllUsers();
    res.json(good({ data: users }));
  })
);

export { users as usersRoute };
