import sql from "../db/db";
import { ProjectTable } from "../interfaces/projectTable";
import { appError } from "../models/appError";
import { CreateProjectBody } from "../routes/api/v1/projects/projectsSchema";

/**
 * Get all projects of a user.
 * @returns Array of projects
 */
export const getAllProjectsOfUser = async (userId: string) => {
  return await sql<ProjectTable[]>`
        SELECT project_id, name, description, created_at
        FROM projects
        WHERE owner_id = ${userId}`;
};

/**
 * Create a new project.
 * @param userId
 * @param data project detail
 * @returns created project
 */
export const createProject = async (
  userId: string,
  data: CreateProjectBody
) => {
  const [project] = await sql<ProjectTable[]>`
        INSERT INTO projects (name, description, owner_id)
        VALUES (${data.name}, ${data.description ?? null}, ${userId})
        RETURNING project_id, name, description, created_at`;
  return project;
};

/**
 * Delete a a project.
 * @param userId
 * @param projectId
 */
export const deleteProject = async (userId: string, projectId: string) => {
  const [project] = await sql<ProjectTable[]>`
        SELECT owner_id FROM projects
        WHERE project_id = ${projectId}`;

  if (!project) throw appError("Project not found", 404);

  if (project.owner_id !== userId) throw appError("Permission denied", 403);

  // Begin transaction to delete project and related data
  await sql.begin(async (sql) => {
    // Delete all comments related to this project
    await sql`
        DELETE FROM task_comment
        WHERE
          task_id IN (
            SELECT
              task_id
            FROM
              tasks
            WHERE
              project_id = ${projectId}
          )`;

    // Delete all tasks related to this project
    await sql`
        DELETE FROM tasks
        WHERE project_id = ${projectId}`;

    // Delete this project
    await sql`
        DELETE FROM projects
        WHERE project_id = ${projectId}`;
  });
};
