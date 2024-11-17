import { Router } from "express";
import {
  createUser,
  getAllUsers,
} from "../../../../controllers/usersController";
import { good } from "../../../../utils/response";
import { tryCatch } from "../../../../utils/tryCatch";

/**
 * "/api/v1/users" route.
 */
const users = Router();

// /api/v1/users/
users.get(
  "/",
  tryCatch(async (req, res) => {
    const users = await getAllUsers();
    res.json(good({ data: users }));
  })
);

users.post(
  "/",
  // TODO: add validation
  tryCatch(async (req, res) => {
    const { name, age } = req.body;
    const users = await createUser(name, age);
    res.json(
      good({
        message: "User created successfully",
        data: users[0],
      })
    );
  })
);

export { users as usersRoute };
