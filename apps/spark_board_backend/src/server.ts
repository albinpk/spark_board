import dotenv from "dotenv";
dotenv.config();

import bodyParser from "body-parser";
import express from "express";
import { errorHandler } from "./middlewares/errorHandler";
import { notFoundHandler } from "./middlewares/notFound";
import { usersRoute } from "./routes/usersRoute";
import { ok } from "./utils/response";
import { tryCatch } from "./utils/tryCatch";

const port = process.env.PORT;

const app = express();
app.use(bodyParser.json());

// root
app.get(
  "/",
  tryCatch(async (_, res) => res.json(ok()))
);

// routes
app.use("/users", usersRoute);

// error handlers
app.all("*", notFoundHandler);
app.use(errorHandler);

app.listen(port, () => console.log(`Server is running on port ${port}`));
