/**
 * Interface for tasks table.
 */
export interface TaskTable {
  id: number;
  task_id: number;
  project_id: string;
  name: string;
  description: string;
  status: string;
  created_at: Date;
}
