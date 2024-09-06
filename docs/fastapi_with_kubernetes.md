I want to create and run a FastAPI Python app named as "fastapi-backend".

The app will use Docker.
The app will be connected to a Postgres database also running in a container. 
Postgres Detail:
container name: pg-db
userid : myuser
userpassword : mypassword
pg database name: mydatabase

A table is created named "persons"
Table already contains 3 rows of data. 

Can you please show me step by step how to create the FastAPI fastapi-backend app where I can get all rows from database 

# -------------------------------------

Here's a step-by-step guide to creating and running your FastAPI app named `fastapi-backend`, which will connect to a PostgreSQL database running in a Docker container:

### Step 1: Set Up the PostgreSQL Container
First, ensure your PostgreSQL container is running. If it's not already set up, you can create and run the container using the following `docker run` command:

```bash
docker run --name pg-db -e POSTGRES_USER=myuser -e POSTGRES_PASSWORD=mypassword -e POSTGRES_DB=mydatabase -p 5432:5432 -d postgres
```

### Step 2: Create the FastAPI Application

1. **Project Directory Structure**:

   Create the directory structure for your FastAPI project:

   ```bash
   mkdir fastapi-backend
   cd fastapi-backend
   mkdir app
   touch app/main.py
   touch app/__init__.py
   touch app/models.py
   touch app/database.py
   touch app/schemas.py
   touch app/crud.py
   ```

2. **Create and Populate `app/main.py`**:

   This file contains the main entry point for your FastAPI application.

   ```python
   from fastapi import FastAPI, Depends
   from sqlalchemy.orm import Session
   from app import models, schemas, crud
   from app.database import engine, SessionLocal

   # Initialize the FastAPI app
   app = FastAPI()

   # Create the database tables
   models.Base.metadata.create_all(bind=engine)

   # Dependency to get the database session
   def get_db():
       db = SessionLocal()
       try:
           yield db
       finally:
           db.close()

   @app.get("/persons/", response_model=list[schemas.Person])
   def get_persons(db: Session = Depends(get_db)):
       persons = crud.get_persons(db)
       return persons
   ```

3. **Create and Populate `app/models.py`**:

   This file contains your SQLAlchemy models.

   ```python
   from sqlalchemy import Column, Integer, String
   from app.database import Base

   class Person(Base):
       __tablename__ = "persons"

       id = Column(Integer, primary_key=True, index=True)
       first_name = Column(String, index=True)
       last_name = Column(String, index=True)
   ```

4. **Create and Populate `app/schemas.py`**:

   This file defines the Pydantic models for request and response validation.

   ```python
   from pydantic import BaseModel

   class Person(BaseModel):
       id: int
       first_name: str
       last_name: str

       class Config:
           orm_mode = True
   ```

5. **Create and Populate `app/crud.py`**:

   This file handles database operations.

   ```python
   from sqlalchemy.orm import Session
   from app import models

   def get_persons(db: Session):
       return db.query(models.Person).all()
   ```

6. **Create and Populate `app/database.py`**:

   This file handles the database connection setup.

   ```python
   from sqlalchemy import create_engine
   from sqlalchemy.ext.declarative import declarative_base
   from sqlalchemy.orm import sessionmaker

   SQLALCHEMY_DATABASE_URL = "postgresql://myuser:mypassword@pg-db/mydatabase"

   engine = create_engine(SQLALCHEMY_DATABASE_URL)
   SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

   Base = declarative_base()
   ```

### Step 3: Create the Dockerfile for FastAPI

Create a `Dockerfile` for the FastAPI app:

```Dockerfile
# Use the official Python image
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the FastAPI app files
COPY . .

# Expose the port
EXPOSE 8000

# Command to run the FastAPI app
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

### Step 4: Create `requirements.txt`

Create a `requirements.txt` file that lists the dependencies:

```text
fastapi
uvicorn
sqlalchemy
psycopg2-binary
```

### Step 5: Build and Run the FastAPI Docker Container

1. Build the Docker image for your FastAPI app:

   ```bash
   docker build -t fastapi-backend .
   ```

2. Run the FastAPI container and link it to the PostgreSQL container:

   ```bash
   docker run --name fastapi-backend --link pg-db:pg-db -p 8000:8000 -d fastapi-backend
   ```

### Step 6: Access the API

With the containers running, you can access the FastAPI app and retrieve the rows from the `persons` table by navigating to:

```bash
http://localhost:8000/persons/
```

This endpoint should return all the rows from the `persons` table in the PostgreSQL database.

### Step 7: (Optional) View Swagger Documentation

FastAPI provides an auto-generated Swagger UI. You can view it at:

```bash
http://localhost:8000/docs
```

This guide provides a complete solution for setting up and running your FastAPI app connected to a PostgreSQL database using Docker.