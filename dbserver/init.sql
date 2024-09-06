-- Create the persons table
CREATE TABLE persons (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

-- Insert three test rows into the persons table
INSERT INTO persons (first_name, last_name) VALUES ('John', 'Doe');
INSERT INTO persons (first_name, last_name) VALUES ('Jane', 'Smith');
INSERT INTO persons (first_name, last_name) VALUES ('Emily', 'Johnson');
