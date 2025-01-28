# **Spark Board Backend**

The **Spark Board Backend** is a RESTful API server built with **Express.js** to manage tasks, projects, and user authentication for the Spark Board application. It uses **JWT** for secure authentication and **PostgreSQL** for reliable data storage, leveraging `express-postgres` for database interaction without an ORM. The backend is fully documented with **Swagger UI** for easy API testing and integration.

---

## **Features**

- **User Authentication**: Secure signup and login with JWT-based token management.
- **Task and Project Management**: Comprehensive CRUD APIs for tasks, projects, and staff.
- **Task Assignment**: Easily assign or unassign staff to tasks.
- **Task Status Tracking**: Update and manage the status of tasks effectively.
- **Task Comments**: Add and manage comments for task collaboration.
- **Profile Management**: APIs for managing staff profiles.
- **Database Integration**: Efficiently handles PostgreSQL operations for user, project, and task data.
- **API Documentation**: Swagger UI and Postman collections for streamlined testing and development.

---

## **Tech Stack**

- **Backend Framework**: Express.js
- **Authentication**: JWT (JSON Web Tokens)
- **Database**: PostgreSQL (direct SQL queries using express-postgres)
- **API Documentation**: Swagger UI, Postman
- **Deployment**: Dockerized for easy local and production setup

---

## **API Documentation**

- **Swagger UI**: Access the API documentation at `/api-docs` after starting the server.
- **Postman Collection**: A detailed Postman collection is available in the `swagger` directory for local testing and integration.

---

## **Key Enhancements**

- **Error Handling**: Global error handling for consistent API responses.
- **Cross-Origin Resource Sharing (CORS)**: Enabled for secure API access.
- **Docker Integration**: Simplified local development and production deployment with pre-configured Docker support.
<!-- - **Dummy Data**: Preloaded SQL scripts with sample users, projects, tasks, and assignments for testing. -->
