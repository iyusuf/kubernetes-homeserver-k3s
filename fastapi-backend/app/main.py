from fastapi import FastAPI, Depends
from fastapi.middleware.cors import CORSMiddleware
# from sqlalchemy.orm import Session
# from app import models, schemas, crud
# from app.database import engine, SessionLocal
from app import db

# Initialize the FastAPI app
app = FastAPI()

# Enable CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins
    allow_credentials=True,
    allow_methods=["*"],  # Allows all methods
    allow_headers=["*"],  # Allows all headers
)

# # Create the database tables
# models.Base.metadata.create_all(bind=engine)

# Dependency to get the database session
# def get_db():
#     db = SessionLocal()
#     try:
#         yield db
#     finally:
#         db.close()

# @app.get("/persons/", response_model=list[schemas.Person])
# def get_persons(db: Session = Depends(get_db)):
#     persons = crud.get_persons(db)
#     return persons

@app.get("/persons/")
def get_persons():
    persons = db.get_data()
    return persons

@app.get("/heartbeat/")
def get_version():
    return "I am alive 2"

@app.get("/echo/")
def get_version():
    return "Hello World 2"
