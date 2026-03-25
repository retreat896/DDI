import os
from flask import Flask, render_template
import psycopg
from psycopg.rows import dict_row

app = Flask(__name__)


def get_db_connection():
    # Read DB settings from environment variables. Do NOT hard-code passwords.
    db_name = os.getenv("DB_NAME")
    db_host = os.getenv("DB_HOST")
    return psycopg.connect(
        host=db_host,
        dbname=db_name,
        user=db_name,
        password=os.getenv("PW"),  # System env var
        row_factory=dict_row
    )


@app.route('/persons')
def list_persons():
    try:
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute("""
                    SELECT
                        id,
                        first_name,
                        last_name,
                        major,
                        minor,
                        favorite_food
                    FROM test_schema.persons;
                """)
                persons = cur.fetchall()

        return render_template('persons.html', persons=persons)

    except Exception as e:
        # Returns the error for easier troubleshooting on the lab server
        return f"Database error: {e}", 500


if __name__ == "__main__":
    app.run(debug=True)