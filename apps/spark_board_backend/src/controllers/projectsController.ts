import sql from "../db";
import { ProjectTable } from "../interfaces/projectTable";
import { CreateProjectBody } from "../routes/api/v1/projects/projectsSchema";

/**
 * Get all projects of a user.
 * @returns Array of projects
 */
export const getAllProjectsOfUser = async (userId: string) => {
  const projects = await sql<ProjectTable[]>`
        SELECT project_id, name, description, created_at
        FROM projects
        WHERE owner_id = ${userId}`;
  return projects;
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
  const project = await sql<ProjectTable[]>`
        INSERT INTO projects (name, description, owner_id)
        VALUES (${data.name}, ${data.description ?? null}, ${userId})
        RETURNING project_id, name, description, created_at`;
  return project[0];
};
