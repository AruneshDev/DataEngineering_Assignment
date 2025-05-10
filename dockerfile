# Use official Python image
FROM python:3.10

# Set working directory
WORKDIR /app

# Install PostgreSQL client tools
RUN apt-get update && apt-get install -y postgresql postgresql-client

# Copy project files
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

CMD ["tail", "-f", "/dev/null"]
