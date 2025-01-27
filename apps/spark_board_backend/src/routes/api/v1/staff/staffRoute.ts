import { Router } from "express";
import {
  createStaff,
  deleteStaff,
  getAllStaff,
  updateStaff,
} from "../../../../controllers/staffController";
import { validator } from "../../../../middlewares/reqValidator";
import { good } from "../../../../utils/response";
import { tryCatch } from "../../../../utils/tryCatch";
import {
  CreateStaffBody,
  createStaffSchema,
  UpdateStaffBody,
  updateStaffSchema,
} from "./staffSchema";

/**
 * "/api/v1/staff" route.
 */
const staff = Router();

// api/v1/staff/
staff.get(
  "/",
  tryCatch(async (req, res) => {
    const staff = await getAllStaff();
    res.json(good({ data: staff }));
  })
);

// api/v1/staff/
staff.post(
  "/",
  validator(createStaffSchema),
  tryCatch<CreateStaffBody>(async (req, res) => {
    const staff = await createStaff(req.body);
    res.json(good({ data: staff, message: "Created successfully" }));
  })
);

// api/v1/staff/:staffId
staff.patch(
  "/:staffId",
  validator(updateStaffSchema),
  tryCatch<UpdateStaffBody>(async (req, res) => {
    const staff = await updateStaff(req.params.staffId, req.body);
    res.json(good({ data: staff, message: "Updated successfully" }));
  })
);

// api/v1/staff/:staffId
staff.delete(
  "/:staffId",
  tryCatch(async (req, res) => {
    await deleteStaff(req.params.staffId);
    res.json(good({ message: "Deleted successfully" }));
  })
);

export { staff as staffRoute };
