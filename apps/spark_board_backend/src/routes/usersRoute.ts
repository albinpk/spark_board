import { Router } from "express";
import { createUser, getAllUsers } from "../controllers/usersController";
import { ok } from "../utils/response";
import { tryCatch } from "../utils/tryCatch";

/**
 * "/users" route.
 */
const users = Router();

users.get(
  "/",
  tryCatch(async (req, res) => {
    const users = await getAllUsers();
    res.json(ok({ data: { data: users } }));
  })
);

users.post(
  "/",
  tryCatch(async (req, res) => {
    const { name, age } = req.body;
    const users = await createUser(name, age);
    res.json(
      ok({
        message: "User created successfully",
        data: users[0],
      })
    );
  })
);

export { users as usersRoute };
