import sql from "../db";
import { ProjectTable } from "../interfaces/projectTable";
import { TaskTable } from "../interfaces/taskTable";
import { appError } from "../models/appError";
import { CreateTaskBody } from "../routes/api/v1/projects/tasks/tasksSchema";

/**
 * Get all tasks of a project.
 * @param userId
 * @param projectId
 * @returns list of tasks
 */
export const getAllTasksOfProject = async (
  userId: string,
  projectId: string
) => {
  const [project] = await sql<ProjectTable[]>`
    SELECT owner_id FROM projects
    WHERE project_id = ${projectId}`;

  if (!project) throw appError("Project not found", 404);

  if (project.owner_id !== userId) throw appError("Permission denied", 403);

  return await sql<TaskTable[]>`
    SELECT
        task_id,
        name,
        description,
        status,
        created_at
    FROM
        tasks
    WHERE
        project_id = ${projectId}`;
};

/**
 * Create a new task.
 * @param userId
 * @param projectId
 * @param task
 * @returns created task
 */
export const createTask = async (
  userId: string,
  projectId: string,
  task: CreateTaskBody
) => {
  const [project] = await sql<ProjectTable[]>`
    SELECT owner_id FROM projects
    WHERE project_id = ${projectId}`;

  if (!project) throw appError("Project not found", 404);

  if (project.owner_id !== userId) throw appError("Permission denied", 403);

  const [createdTask] = await sql<TaskTable[]>`
    INSERT INTO
      tasks (project_id, name, description, status)
    VALUES
      (
        ${projectId},
        ${task.name},
        ${task.description ?? null},
        ${task.status ?? null}
      )
    RETURNING
      task_id,
      name,
      description,
      status,
      created_at;`;
  return createdTask;
};

/**
 * Delete a task.
 * @param userId
 * @param projectId
 * @param taskId
 */
export const deleteTask = async (userId: string, taskId: string) => {
  const [task] = await sql`
    SELECT
      p.owner_id
    FROM
      tasks t
      JOIN projects p ON t.project_id = p.project_id
    WHERE
      t.task_id = ${taskId}`;

  if (!task) throw appError("Task not found", 404);

  if (task.owner_id !== userId) throw appError("Permission denied", 403);

  await sql`
    DELETE FROM tasks
    WHERE task_id = ${taskId}`;
};
