# **Spark Board Backend**

The **Spark Board Backend** is built with **Express.js** and provides RESTful APIs for managing tasks and projects. It uses **JWT** for user authentication and connects to **PostgreSQL** for data storage without an ORM, utilizing `express-postgres` for database interaction.

---

## **Features**

- User authentication with JWT.
- CRUD operations for tasks and projects.
- Database connection to PostgreSQL.

---

## **Tech Stack**

- **Backend Framework**: Express.js
- **Authentication**: JWT
- **Database**: PostgreSQL (no ORM, using express-postgres)
- **API Documentation**: Swagger UI, Postman

---

## **API Documentation**

- The API documentation is available through **Swagger UI** at `/api-docs` after running the server.
- Postman collections for API testing are available in the `swagger` directory.
