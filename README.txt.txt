# Docker Optimization Project

## Project Overview
This project runs a Flask web application and PostgreSQL database using Docker Compose.

## Technologies Used
- Python
- Flask
- Gunicorn
- PostgreSQL
- Docker
- Docker Compose

## Features
- Multi-stage Docker build
- Lightweight Python application image
- Gunicorn production server
- PostgreSQL database container
- Docker Compose orchestration
- Container health checks
- Persistent database storage using named volumes
- Environment variables using .env
- .dockerignore to exclude unnecessary files
- Container restart testing

## Application Endpoints
- / - Home page
- /health - Application health check
- /db-health - Database connection health check

## How to Run

1. Open CMD in the project folder.
2. Run:

docker compose up -d --build

3. Check containers:

docker compose ps

4. Open http://localhost:5000 in your browser.

## How to Stop

docker compose down

Note: Database data is preserved because the named volume is not deleted.

## Project Status
Application and database containers have been successfully built, started, tested, and restarted.
