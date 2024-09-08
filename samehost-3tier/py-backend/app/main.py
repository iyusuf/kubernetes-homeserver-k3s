from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

# Define the data model
class Person(BaseModel):
    first_name: str
    last_name: str

# In-memory database (for simplicity)
persons_db = [
    {"first_name": "John", "last_name": "Doe"},
    {"first_name": "Jane", "last_name": "Doe"}
]

# Get all persons
@app.get("/persons")
async def get_persons():
    return persons_db

# Add a new person
@app.post("/persons")
async def add_person(person: Person):
    persons_db.append(person.dict())
    return {"message": "Person added successfully"}
