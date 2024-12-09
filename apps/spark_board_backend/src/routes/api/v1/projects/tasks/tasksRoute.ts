import { Router } from "express";
import {
  assignTask,
  createTask,
  deleteTask,
  getAllTasksOfProject,
  unassignTask,
  updateTask,
} from "../../../../../controllers/tasksController";
import { validator } from "../../../../../middlewares/reqValidator";
import { good } from "../../../../../utils/response";
import { tryCatch } from "../../../../../utils/tryCatch";
import {
  AssignTaskBody,
  assignTaskSchema,
  CreateTaskBody,
  createTaskSchema,
  UpdateTaskBody,
  updateTaskSchema,
} from "./tasksSchema";

/**
 * "/api/v1/projects/:projectId/tasks" route.
 */
const tasks = Router({ mergeParams: true });

// api/v1/projects/:projectId/tasks/
tasks.get(
  "/",
  tryCatch(async (req, res) => {
    const projectId = req.params["projectId"];
    const tasks = await getAllTasksOfProject(req.userId, projectId);
    res.json(good({ data: tasks }));
  })
);

// api/v1/projects/:projectId/tasks/
tasks.post(
  "/",
  validator(createTaskSchema),
  tryCatch<CreateTaskBody>(async (req, res) => {
    const projectId = req.params["projectId"];
    const project = await createTask(req.userId, projectId, req.body);
    res.json(good({ data: project }));
  })
);

// api/v1/projects/:projectId/tasks/:taskId
tasks.patch(
  "/:taskId",
  validator(updateTaskSchema),
  tryCatch<UpdateTaskBody>(async (req, res) => {
    const updatedTask = await updateTask(
      req.userId,
      req.params.taskId,
      req.body
    );
    res.json(good({ message: "Task updated successfully", data: updatedTask }));
  })
);

// api/v1/projects/:projectId/tasks/:taskId
tasks.delete(
  "/:taskId",
  tryCatch(async (req, res) => {
    await deleteTask(req.userId, req.params.taskId);
    res.json(good({ message: "Task deleted successfully" }));
  })
);

// api/v1/projects/:projectId/tasks/:taskId/assign
tasks.post(
  "/:taskId/assign",
  validator(assignTaskSchema),
  tryCatch<AssignTaskBody>(async (req, res) => {
    await assignTask(req.userId, req.params.taskId, req.body);
    res.json(good({ message: "Task assigned successfully" }));
  })
);

// api/v1/projects/:projectId/tasks/:taskId/assign
tasks.delete(
  "/:taskId/assign",
  tryCatch(async (req, res) => {
    await unassignTask(req.userId, req.params.taskId);
    res.json(good({ message: "Task unassigned successfully" }));
  })
);

export { tasks as tasksRoutes };
