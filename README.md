# Project Overview multi_container_application
This project creates a multi-container application using Docker Compose. The docker compose file creates a service that enables multiple container application to run and communicate via a common network. The Docker compose defines the entire multi-container application in a single YAML file, eliminating the need to run multiple docker run commands. The file specifies configurations for the CSV app and Database app containers, their dependencies which are saved in the requirement.txt, environment variables, volumes and networks. 
## Multi Container Application Functionalities
You have developed a Streamlit application with the following functionalities:

A user interface for CSV file upload.
Once a CSV file is uploaded, the application loads it into a PostgreSQL database table for persistence.
The application reads the loaded data from the PostgreSQL database table.
The application displays the first 5 rows and the summary statistics of the numerical columns in the table.
The application is implemented in the data_process_db.py script in this repository.

Since this application requires a PostgreSQL database, you need to run a PostgreSQL container and connect to it from the container running your application. To achieve this, you will create a multi-container application using Docker Compose.

Task
Your manager has tasked you with:

Packaging this application and its dependencies into a Docker image for easy deployment.
Pushing the application image to Docker Hub so team members can easily download and run it.
Creating a multi-container setup using Docker Compose.
Step-by-Step Instructions
Set Up Your Project

Create a new folder on your PC and navigate into it.
Clone this repository into the new folder.
Create and Write a Dockerfile

Package the application into a Docker image.
Use a lightweight Python image as the base image.
Copy and install the application dependencies (requirements.txt).
Sets environment variables using .env
Copy the application code into the image.
Expose port 8501 for the application.
Set the container's entrypoint to run the application using:
streamlit run <path/filename.py>
Ensure the image follows best practices to leverage Docker build caching.
Build the Docker Image

Build the application image using Docker.
Create Docker Compose Configuration

Create a compose.yml file.
Define services to run the multi-container application:
Application Service

Uses the Dockerfile to build the docker image.
Maps ports for external access.
Mounts volumes for persistence of database data.
Passes the following environment variables securely (via .env file):
environment:
  POSTGRES_HOST: app-db
  POSTGRES_USER: <username>
  POSTGRES_PASSWORD: <password>
  POSTGRES_DB: postgres
  POSTGRES_PORT: 5432
Depends on the database service.
Database Service

Uses a lightweight PostgreSQL image.
Uses the following environment variable:
environment:
  POSTGRES_PASSWORD: <password>
Persists database data using Docker volumes.
Run the Multi-Container Application

Start your application using Docker Compose
Access the Web Application

Open your browser and navigate to http://localhost:8501.
Upload the student.csv file available in this repo.
Confirm the application works as expected.
Verify Database Persistence

Execute into your database container:
docker exec -it <database_container_id> psql -U postgres
Run the following SQL command to confirm the uploaded data is present:
SELECT * FROM student;
Push Your Application Image to Docker Hub

Tag and push your Docker image to Docker Hub
Deliverables
Submit a GitHub repo containing your Dockerfile and compose.yml file with a clear README.
Provide a link to your Docker image on Docker Hub.

