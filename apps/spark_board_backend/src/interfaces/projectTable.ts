/**
 * Interface for projects table
 */
export interface ProjectTable {
  id: number;
  project_id: number;
  owner_id: string;
  name: string;
  description: string;
  created_at: Date;
}
