import jwt from "jsonwebtoken";

/**
 * Interface for jwt data.
 */
interface Jwt {
  userId: string;
}

/**
 * Create json web token with given data.
 * @param data Jwt
 * @returns token
 */
export const createToken = (data: Jwt) => {
  // TODO: Update expiresIn
  return jwt.sign(data, process.env.JWT_SECRET!, { expiresIn: "1h" });
};

/**
 * Verify jwt token and returns decoded data.
 * @param token jwt token
 * @returns Jwt data
 */
export const verifyToken = (token: string): Jwt => {
  return jwt.verify(token, process.env.JWT_SECRET!) as Jwt;
};
