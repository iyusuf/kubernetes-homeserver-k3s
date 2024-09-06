import psycopg2
import json

def get_data():

    # Connect to your PostgreSQL database
    conn = psycopg2.connect(
        dbname="mydatabase",
        user="myuser",
        password="mypassword",
        host="localhost",
        port="5432"
    )

    # Create a cursor object
    cursor = conn.cursor()

    # Execute a query to retrieve data from a table
    cursor.execute("SELECT * FROM persons")
    rows = cursor.fetchall()

    # Get the column names
    columns = [desc[0] for desc in cursor.description]

    # Convert the rows into a list of dictionaries
    data = [dict(zip(columns, row)) for row in rows]

    # Convert the list of dictionaries to JSON
    json_data = json.dumps(data, indent=4)

    # Print the JSON data
    print(json_data)

    # Close the cursor and the connection
    cursor.close()
    conn.close()
    
    return json_data
