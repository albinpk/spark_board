import { Router } from "express";
import { v1Route } from "./v1/v1Routes";

/**
 * "/api" route.
 */
const api = Router();

// /api/v1
api.use("/v1", v1Route);

export { api as apiRoutes };
