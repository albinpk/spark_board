import { Router } from "express";
import {
  createProject,
  deleteProject,
  getAllProjectsOfUser,
} from "../../../../controllers/projectsController";
import { validator } from "../../../../middlewares/reqValidator";
import { good } from "../../../../utils/response";
import { tryCatch } from "../../../../utils/tryCatch";
import { CreateProjectBody, createProjectSchema } from "./projectsSchema";

/**
 * "/api/v1/projects" route.
 */
const projects = Router();

// api/v1/projects/
projects.get(
  "/",
  tryCatch(async (req, res) => {
    const projects = await getAllProjectsOfUser(req.userId);
    res.json(good({ data: projects }));
  })
);

// api/v1/projects/
projects.post(
  "/",
  validator(createProjectSchema),
  tryCatch<CreateProjectBody>(async (req, res) => {
    const projects = await createProject(req.userId, req.body);
    res.json(good({ data: projects }));
  })
);

// api/v1/projects/:projectId
projects.delete(
  "/:projectId",
  tryCatch(async (req, res) => {
    await deleteProject(req.userId, req.params["projectId"]);
    res.json(good({ message: "Project deleted successfully" }));
  })
);

export { projects as projectsRoute };
