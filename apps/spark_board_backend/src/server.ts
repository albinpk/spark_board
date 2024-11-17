import dotenv from "dotenv";
dotenv.config();

import bodyParser from "body-parser";
import express from "express";
import { logHandler } from "./middlewares/apiLogger";
import { errorHandler } from "./middlewares/errorHandler";
import { notFoundHandler } from "./middlewares/notFound";
import { apiRoutes } from "./routes/api/apiRoutes";

const port = process.env.PORT;

const app = express();
app.use(bodyParser.json());

app.use(logHandler);

// routes
app.use("/api", apiRoutes);
// app.use("/users", usersRoute);

// error handlers
app.all("*", notFoundHandler);
app.use(errorHandler);

app.listen(port, () => console.log(`Server is running on port ${port}`));
