import sql from "../db";
import { ProjectTable } from "../interfaces/projectTable";
import { TaskTable } from "../interfaces/taskTable";
import { appError } from "../models/appError";
import {
  AssignTaskBody,
  CreateTaskBody,
  UpdateTaskBody,
} from "../routes/api/v1/projects/tasks/tasksSchema";

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
      t.task_id,
      t.name,
      t.description,
      t.status,
      t.created_at,
      CASE
        WHEN s.staff_id IS NOT NULL THEN json_build_object(
          'staff_id',
          s.staff_id,
          'name',
          s.name,
          'email',
          s.email
        )
        ELSE NULL
      END assignee
    FROM
      tasks t
      LEFT JOIN task_assignee a ON a.task_id = t.task_id
      LEFT JOIN staff s ON s.staff_id = a.staff_id
    WHERE
      t.project_id = ${projectId}`;
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
 * Update a task.
 * @param userId
 * @param taskId
 * @param body update task body
 * @returns updated task
 */
export const updateTask = async (
  userId: string,
  taskId: string,
  body: UpdateTaskBody
) => {
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

  const [updatedTask] = await sql<TaskTable[]>`
    UPDATE tasks
    SET
      name = COALESCE(NULLIF(${body.name ?? null}, NULL), name),
      description = COALESCE(NULLIF(${
        body.description ?? null
      }, NULL), description),
      status = COALESCE(NULLIF(${
        body.status ?? null
      }, NULL)::task_status, status)
    WHERE
      task_id = ${taskId}
    RETURNING
      task_id,
      name,
      description,
      status,
      created_at;`;
  return updatedTask;
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

/**
 * Assign a task to a staff.
 * @param userId
 * @param taskId
 * @param body assign task body
 */
export const assignTask = async (
  userId: string,
  taskId: string,
  body: AssignTaskBody
) => {
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
    INSERT INTO
      task_assignee (task_id, staff_id)
    VALUES
      (${taskId}, ${body.staffId})
    ON CONFLICT (task_id) DO
    UPDATE
    SET
      staff_id = excluded.staff_id`;
};

/**
 * Unassign a task from a staff.
 * @param userId
 * @param taskId
 */
export const unassignTask = async (userId: string, taskId: string) => {
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
    DELETE FROM task_assignee
    WHERE
      task_id = ${taskId}`;
};
