/**
 * Interface for users table.
 */
export interface UserTable {
  id: number;
  user_id: string;
  name: string;
  email: string;
  password: string;
  created_at: Date;
}
