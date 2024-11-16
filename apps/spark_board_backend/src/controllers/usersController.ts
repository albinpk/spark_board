import sql from "../db";
import { User } from "../interfaces/userInterface";

/**
 * Get all users from users table.
 * @returns Array of users
 */
export const getAllUsers = async () => {
  const users = await sql<User[]>`select * from users`;
  return users;
};

/**
 * Insert a new user to users table.
 * @param name user name
 * @param age user age
 * @returns created user
 */
export const createUser = async (name: string, age: number) => {
  const user = await sql<User[]>`
    insert into users (name, age)
    values (${name}, ${age})
    returning *`;
  return user;
};
