import sql from "../db/db";
import { StaffTable } from "../interfaces/staffTable";
import { appError } from "../models/appError";
import {
  CreateStaffBody,
  UpdateStaffBody,
} from "../routes/api/v1/staff/staffSchema";

/**
 * Get list of staff.
 * @returns Array of staff
 */
export const getAllStaff = async () => {
  return await sql<StaffTable[]>`
    SELECT staff_id, name, email, created_at
    FROM staff`;
};

/**
 * Create a new staff.
 * @param body create staff body
 * @returns created staff
 */
export const createStaff = async (body: CreateStaffBody) => {
  const [staff] = await sql<StaffTable[]>`
    INSERT INTO
      staff (name, email)
    VALUES
      (${body.name}, ${body.email})
    RETURNING
      staff_id,
      name,
      email,
      created_at;`;
  return staff;
};

/**
 * Update a staff.
 * @param staffId
 * @param body update staff body
 * @returns updated staff
 */
export const updateStaff = async (staffId: string, body: UpdateStaffBody) => {
  const [staff] = await sql<StaffTable[]>`
    UPDATE staff
    SET
      name = COALESCE(NULLIF(${body.name}, NULL), name)
    WHERE
      staff_id = ${staffId}
    RETURNING
      staff_id,
      name,
      email,
      created_at;`;

  if (!staff) throw appError("Staff not found", 404);

  return staff;
};

/**
 * Delete a staff.
 * @param staffId
 */
export const deleteStaff = async (staffId: string) => {
  const [staff] = await sql`
    DELETE FROM staff
    WHERE
      staff_id = ${staffId}
    RETURNING
      staff_id;`;

  if (!staff) throw appError("Staff not found", 404);
};
