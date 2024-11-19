import { Router } from "express";
import {
  createProject,
  getAllProjectsOfUser,
} from "../../../../controllers/projectsController";
import { validator } from "../../../../middlewares/reqValidator";
import { good } from "../../../../utils/response";
import { tryCatch } from "../../../../utils/tryCatch";
import { CreateProjectBody, createProjectSchema } from "./projectsSchema";

const projects = Router();

projects.get(
  "/",
  tryCatch(async (req, res) => {
    const projects = await getAllProjectsOfUser(req.userId);
    res.json(good({ data: projects }));
  })
);

projects.post(
  "/",
  validator(createProjectSchema),
  tryCatch<CreateProjectBody>(async (req, res) => {
    const projects = await createProject(req.userId, req.body);
    res.json(good({ data: projects }));
  })
);

export { projects as projectsRoute };
