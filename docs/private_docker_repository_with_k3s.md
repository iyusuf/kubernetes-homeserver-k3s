Postgres with Docker and Docker Hub registry


# Here’s how you can create a `Dockerfile` that sets up a PostgreSQL database with a `persons` table.

### Step 1: Create the `Dockerfile`

Create a file named `Dockerfile` in your project directory with the following content:

```dockerfile
# Use the official PostgreSQL image from the Docker Hub
FROM postgres:14

# Set environment variables for the database
ENV POSTGRES_USER=yourusername
ENV POSTGRES_PASSWORD=yourpassword
ENV POSTGRES_DB=yourdatabase

# Copy the SQL script to create the table into the Docker image
COPY init.sql /docker-entrypoint-initdb.d/
```

### Step 2: Create the SQL Script (`init.sql`)

In the same directory as the `Dockerfile`, create a file named `init.sql` with the following content:

```sql
CREATE TABLE persons (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);
```

### Step 3: Build the Docker Image

To build the Docker image with PostgreSQL and the `persons` table, run the following command in the directory containing your `Dockerfile` and `init.sql`:

```bash
docker build -t my-postgres-image .
```

### Step 4: Run the Docker Container

After building the image, you can run a container based on this image:

```bash
docker run --name my-postgres-container -d my-postgres-image
```

### Step 5: Verify the Setup

You can verify that the table was created by connecting to the PostgreSQL database:

```bash
docker exec -it my-postgres-container psql -U myuser -d mydatabase
```

Then, in the PostgreSQL prompt, run:

```sql
\d persons
```

This command will show the structure of the `persons` table, confirming that it has been created successfully.







Yes, you can add test rows to the `persons` table using the `init.sql` file. Here’s how you can modify the `init.sql` file to insert three test rows:

### Updated `init.sql`

```sql
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
```

### Steps to Implement

1. **Update the `init.sql` File**:
   Ensure your `init.sql` file contains the commands above.

2. **Build the Docker Image Again**:
   Since the `init.sql` file has been updated, rebuild the Docker image:
   ```bash
   docker build -t my-postgres-image .
   ```

3. **Run the Docker Container**:
   Run the container using the updated image:
   ```bash
   docker run --name my-postgres-container -d my-postgres-image
   ```

### Verify the Rows

To verify that the test rows were inserted correctly:

1. **Connect to the PostgreSQL Database**:
   ```bash
   docker exec -it my-postgres-container psql -U myuser -d mydatabase
   ```

2. **Query the `persons` Table**:
   Run the following query:
   ```sql
   SELECT * FROM persons;
   ```

You should see the following output:

```plaintext
 id | first_name | last_name 
----+------------+-----------
  1 | John       | Doe
  2 | Jane       | Smith
  3 | Emily      | Johnson
(3 rows)
```

This confirms that the table was created and populated with the test data successfully.


# Push to Docker
To push the Docker image to your private Docker Hub registry under the username `iyusuf`, follow these steps:

### 1. Tag the Docker Image

Docker images need to be tagged with your Docker Hub username and the repository name before pushing. The format is:

```bash
docker tag local-image-name docker-hub-username/repository-name:tag
```

For example, if your local image is `my-postgres-image` and you want to push it to a repository named `my-postgres-db` with a tag `v1`, run:

```bash
docker tag my-postgres-image iyusuf/my-postgres-db:v1
```

### 2. Log In to Docker Hub

Make sure you are logged into Docker Hub from the command line:

```bash
docker login
```

You will be prompted to enter your Docker Hub username (`iyusuf`) and password.

### 3. Push the Image to Docker Hub

Once logged in and the image is tagged, push the image to your private repository:

```bash
docker push iyusuf/my-postgres-db:v1
```

### 4. Verify the Push

You can verify that the image was successfully pushed by logging into Docker Hub and navigating to your repositories. You should see `my-postgres-db` listed with the tag `v1`.

### Recap

- **Tagging the image**: `docker tag my-postgres-image iyusuf/my-postgres-db:v1`
- **Logging in to Docker Hub**: `docker login`
- **Pushing the image**: `docker push iyusuf/my-postgres-db:v1`

This will push your PostgreSQL image, preconfigured with the `persons` table and test data, to your private Docker Hub repository.


# Can I make Docker Hub repository private when I push from commandline?

When creating a repository on Docker Hub via the command line, there's no direct option to set it as private while pushing an image. However, you can set the repository to private manually on the Docker Hub website or automatically via the Docker Hub API after pushing the image.

### Steps to Make the Repository Private Manually

1. **Push the Image to Docker Hub**:
   ```bash
   docker push iyusuf/my-postgres-db:v1
   ```

2. **Log in to Docker Hub**:
   - Go to [Docker Hub](https://hub.docker.com/) and log in with your credentials.

3. **Make the Repository Private**:
   - Navigate to the repository `my-postgres-db` under your username `iyusuf`.
   - In the repository settings, find the "Visibility" section and toggle it to "Private".

### Automating via Docker Hub API

If you want to automate this process using the Docker Hub API, you can make a `PATCH` request to set the repository to private.

Here’s a basic example using `curl`:

```bash
curl -X PATCH \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -d '{"visibility": "private"}' \
  https://hub.docker.com/v2/repositories/iyusuf/my-postgres-db/
```

You need to replace `YOUR_ACCESS_TOKEN` with a valid Docker Hub access token. You can generate this token from your Docker Hub account under "Account Settings" -> "Security".

### Summary

While the `docker push` command itself doesn’t have an option to set a repository to private, you can easily do it manually through the Docker Hub interface or automate it using the Docker Hub API.

