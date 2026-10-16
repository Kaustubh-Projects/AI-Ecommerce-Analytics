
import os
from pathlib import Path

from dotenv import load_dotenv
from sqlalchemy import create_engine, text
from sqlalchemy.engine import URL


# 1. Find the project folder
project_folder = Path(__file__).resolve().parent.parent

# 2. Load database settings from the .env file
env_file = project_folder / ".env"
load_dotenv(env_file)

# 3. Read database settings
db_host = os.getenv("DB_HOST")
db_port = os.getenv("DB_PORT")
db_name = os.getenv("DB_NAME")
db_user = os.getenv("DB_USER")
db_password = os.getenv("DB_PASSWORD")

# 4. Check whether all settings are available
if not all([db_host, db_port, db_name, db_user, db_password]):
    raise ValueError(
        "Database settings are missing. Check your .env file."
    )

# 5. Build the PostgreSQL connection URL safely
connection_url = URL.create(
    drivername="postgresql+psycopg",
    username=db_user,
    password=db_password,
    host=db_host,
    port=int(db_port),
    database=db_name,
)

# 6. Create the database engine
engine = create_engine(connection_url)

# 7. Test the connection
try:
    with engine.connect() as connection:
        result = connection.execute(
            text("SELECT current_database(), current_user;")
        )
        database, username = result.fetchone()

        print("Database connection successful!")
        print("Database:", database)
        print("Username:", username)

except Exception as error:
    print("Database connection failed.")
    print("Error:", error)

finally:
    engine.dispose()
