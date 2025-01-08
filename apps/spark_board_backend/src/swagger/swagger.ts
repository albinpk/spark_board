import fs from "fs";
import path from "path";
import swaggerJsdoc from "swagger-jsdoc";
import swaggerUi from "swagger-ui-express";
import yaml from "yaml";

// Postman to Openapi
// https://kevinswiber.github.io/postman2openapi/

const swaggerFile = path.join(__dirname, "./SparkBoard.swagger.yaml");
const yamlString = fs.readFileSync(swaggerFile, "utf8");
const definition = yaml.parse(yamlString);

// updating postman environment variable
definition.servers[0].url = "http://localhost:7070/api/v1";

const swaggerDocs = swaggerJsdoc({ definition, apis: [] });

export const swaggerRoutes = [swaggerUi.serve, swaggerUi.setup(swaggerDocs)];
