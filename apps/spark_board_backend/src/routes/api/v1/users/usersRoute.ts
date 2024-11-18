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
 *     summary: Get list of users
 *     tags: [user]
 *     responses:
 *       200:
 *         description: API response
 */
users.get(
  "/",
  tryCatch(async (req, res) => {
    const users = await getAllUsers();
    res.json(good({ data: users }));
  })
);

export { users as usersRoute };
