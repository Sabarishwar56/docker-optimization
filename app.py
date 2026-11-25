
import os
import psycopg
from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return "Welcome to Docker Optimization Project!"

@app.route("/health")
def health():
    return jsonify({"status": "healthy"})

@app.route("/db-health")
def db_health():
    try:
        with psycopg.connect(
            host=os.getenv("DB_HOST", "db"),
            dbname=os.getenv("DB_NAME", "dockerdb"),
            user=os.getenv("DB_USER", "dockeruser"),
            password=os.getenv("DB_PASSWORD", "dockerpass"),
            port=os.getenv("DB_PORT", "5432")
        ) as conn:
            with conn.cursor() as cur:
                cur.execute("SELECT 1")
                result = cur.fetchone()[0]

        return jsonify({
            "database": "connected",
            "result": result
        })

    except Exception:
        return jsonify({
            "database": "unavailable"
        }), 503


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
