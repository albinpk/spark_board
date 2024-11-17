import swaggerJsdoc from "swagger-jsdoc";
import swaggerUi from "swagger-ui-express";

const option: swaggerJsdoc.Options = {
  swaggerDefinition: {
    openapi: "3.0.0",
    info: {
      title: "API for SparkBoard",
      version: "1.0.0",
    },
    // tags: [
    //   {
    //     name: "Auth",
    //     description: "Authentication related endpoints",
    //   },
    // ],
    servers: [
      {
        url: "http://localhost:3000/api",
      },
    ],
  },
  apis: ["**/*.ts"],
};
const swaggerDocs = swaggerJsdoc(option);

export const swaggerRoutes = [swaggerUi.serve, swaggerUi.setup(swaggerDocs)];
