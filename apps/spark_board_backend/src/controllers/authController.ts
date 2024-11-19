import bcrypt from "bcrypt";
import sql from "../db";
import { UserTable } from "../interfaces/userTable";
import { appError } from "../models/appError";
import { LoginBody, SignupBody } from "../routes/api/v1/auth/authSchema";
import { createToken } from "../utils/jwt";

/**
 * Create a new user.
 * @param data signup body
 * @returns user data
 */
export const signupUser = async (
  data: SignupBody
): Promise<{ token: string }> => {
  // hash password
  const salt = await bcrypt.genSalt();
  const hashedPassword = await bcrypt.hash(data.password, salt);

  const user = await sql<UserTable[]>`
    INSERT INTO users (name, email, password)
    VALUES (${data.name}, ${data.email}, ${hashedPassword})
    RETURNING user_id, name, email, created_at`;

  return { token: createToken({ userId: user[0].user_id }) };
};

/**
 * Login existing user.
 * @param data login body
 * @returns user data
 */
export const loginUser = async (
  data: LoginBody
): Promise<{ token: string }> => {
  const [user] = await sql<UserTable[]>`
    SELECT user_id, name, email, password, created_at
    FROM users
    WHERE email = ${data.email}`;

  if (!user || !(await bcrypt.compare(data.password, user.password))) {
    throw appError("Invalid email or password", 400);
  }

  return { token: createToken({ userId: user.user_id }) };
};
