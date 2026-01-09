# Project Overview multi_container_application
This project creates a multi-container application using Docker Compose. The docker compose file creates a service that enables multiple container application to run and communicate via a common network. The Docker compose defines the entire multi-container application in a single YAML file, eliminating the need to run multiple docker run commands. The file specifies configurations for the CSV app and Database app containers, their dependencies which are saved in the requirement.txt, environment variables, volumes and networks. 
## Multi Container Streamlit Application Functionalities
The Streamlit application will have the following functionalities:
- A user interface for CSV file upload.
- Once a CSV file is uploaded, the application loads it into a PostgreSQL     database table for persistence.
- The application reads the loaded data from the PostgreSQL database table.
- The application displays the first 5 rows and the summary statistics of     the numerical columns in the table.

## Task
- Package the application and its dependencies into a Docker image for easy deployment.
- Push the application image to Docker Hub so team members can easily download and run it.
- Create a multi-container setup using Docker Compose.

## Step-by-Step Instructions
### Set up your Project environment
   - Create a new folder using the this command: mkdir <folder_name>
   - Navigate into the folder created with this command: cd <folder_name>
   - Create a Dockerfile. See sample docker file in the repo
       Use a lightweight Python image as the base image.
       Copy and install the application dependencies (requirements.txt).
       Sets environment variables using .env
       Copy the application code into the image.
       Expose port 8501 for the application.
       Set the container's entrypoint to run the application using:
       streamlit run <path/filename.py>
       Ensure the image follows best practices to leverage Docker build  caching.
  - Package the application into a Docker image by building the csv app image using the docker file created with this command:        docker build -t my_streamlit_app:v1 .
  - Pull the postgres 18-alpine image and run it using the below command: 
   docker run -d --name app-db --network csv-app -e    POSTGRES_PASSWORD=postgres postgres:18-alpine     # This download newer image of postgres:18-alpine and set up the container networking



## Create Docker Compose Configuration

- Create a docker compose.yml to run the multi-container apps i.e csv_app & db_app).
- Define services to run the multi-container application:
  ### Application Service
    - Use the Dockerfile to build the docker image.
    - Maps ports for external access.
    - Mounts volumes for persistence of database data.
    - Pass the following environment variables securely (via .env file):
    environment:
      POSTGRES_HOST: app-db
      POSTGRES_USER: <username>
      POSTGRES_PASSWORD: <password>
      POSTGRES_DB: postgres
      POSTGRES_PORT: 5432
    - Depends on the database service.
### Database Service
- Use a lightweight PostgreSQL image.
- Use the following environment variable:
environment:
  POSTGRES_PASSWORD: <password>
- Persists database data using Docker volumes.
- Run the Multi-Container Application. To start application use this command:docker compose up
-- if the docker compose up command is successful you should get result that looks like the below:
✔ dec_docker_training-csv-app               Built                                                                 0.0s
 ✔ Network dec_docker_training_default       Created                                                               0.1s
 ✔ Volume dec_docker_training_app-db-volume  Created                                                               0.0s
 ✔ Container dec_docker_training-app-db-1    Created                                                               0.1s
 ✔ Container dec_docker_training-csv-app-1   Created                                                               0.1s
Attaching to app-db-1, csv-app-1

## Access the Web Application
- Open your browser and navigate to http://localhost:8501.
- Upload the student.csv file available in this repo.
- Confirm the application works as expected.
- Verify Database Persistence

Execute into your database container:
docker exec -it <database_container_id> psql -U postgres
docker exec -it  dec_docker_training-app-db-1 psql -U postgres -d postgres
Run the following SQL command to confirm the uploaded data is present:
- postgres=# \dt  (list all tables in the database
- SELECT * FROM student;  (select all records in the student table)
Push Your Application Image to Docker Hub

Tag and push your Docker image to Docker Hub

Deliverables
Submit a GitHub repo containing your Dockerfile and compose.yml file with a clear README.
Provide a link to your Docker image on Docker Hub.
https://hub.docker.com/repository/docker/bunmij/my_streamlit_app/general

