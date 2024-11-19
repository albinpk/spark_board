import sql from "../db";
import { UserTable } from "../interfaces/userTable";

/**
 * Get all users from users table.
 * @returns Array of users
 */
export const getAllUsers = async () => {
  return await sql<UserTable[]>`
    SELECT user_id, name, email, created_at
    FROM users`;
};
