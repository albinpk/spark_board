import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
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
export const loginUser = async (
  data: LoginBody
): Promise<{ token: string }> => {
  const [user] = await sql<UserTable[]>`
    SELECT user_id, name, email, password, created_at
    FROM users
    WHERE email = ${data.email}`;

  if (!user) throw new Error("Invalid email or password");

  // compare password
  if (!(await bcrypt.compare(data.password, user.password))) {
    throw new Error("Invalid email or password");
  }

  const token = jwt.sign(
    {
      userId: user.user_id,
    },
    process.env.JWT_SECRET!
  );

  return { token };
};
