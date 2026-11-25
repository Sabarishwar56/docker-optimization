
# STAGE 1: BUILDER
FROM python:3.12-alpine AS builder

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir --prefix=/install -r requirements.txt


# STAGE 2: RUNTIME
FROM python:3.12-alpine AS runtime

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Create a non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy installed dependencies from builder
COPY --from=builder /install /usr/local

# Copy application code
COPY app.py .

# Run as non-root user
USER appuser

EXPOSE 5000

# Container health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
 CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:5000/health')" || exit 1

# Start application using Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "app:app"]
