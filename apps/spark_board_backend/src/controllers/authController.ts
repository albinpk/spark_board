import bcrypt from "bcrypt";
import sql from "../db";
import { UserTable } from "../interfaces/userTable";
import { LoginBody, SignupBody } from "../routes/api/v1/auth/authSchema";

/**
 * Create a new user.
 * @param data signup body
 * @returns user data
 */
export const createUser = async (data: SignupBody): Promise<UserTable> => {
  // hash password
  const salt = await bcrypt.genSalt();
  const hashedPassword = await bcrypt.hash(data.password, salt);

  const user = await sql<UserTable[]>`
    INSERT INTO users (name, email, password)
    VALUES (${data.name}, ${data.email}, ${hashedPassword})
    RETURNING user_id, name, email, created_at`;
  return user[0];
};

/**
 * Login existing user.
 * @param data login body
 * @returns user data
 */
export const loginUser = async (data: LoginBody): Promise<{}> => {
  const [user] = await sql<UserTable[]>`
    SELECT user_id, name, email, password, created_at
    FROM users
    WHERE email = ${data.email}`;

  if (!user) throw new Error("Invalid email or password");

  // compare password
  if (!(await bcrypt.compare(data.password, user.password))) {
    throw new Error("Invalid email or password");
  }

  return {
    user_id: user.user_id,
    name: user.name,
    email: user.email,
    created_at: user.created_at,
  };
};
