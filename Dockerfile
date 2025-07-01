#FROM python:3.9

#WORKDIR /app/backend

#COPY requirements.txt /app/backend
#RUN apt-get update \
 #   && apt-get upgrade -y \
  #  && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
   # && rm -rf /var/lib/apt/lists/*


# Install app dependencies
#RUN pip install mysqlclient
#RUN pip install --no-cache-dir -r requirements.txt

#COPY . /app/backend

#EXPOSE 8000
#RUN python manage.py migrate
#RUN python manage.py makemigrations
#CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
#CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

#CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]

FROM python:3.9

WORKDIR /app

# Copy only requirements.txt first to leverage Docker cache
COPY requirements.txt .

# Install system dependencies and Python packages
RUN apt-get update && \
    apt-get install -y gcc default-libmysqlclient-dev pkg-config && \
    pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    rm -rf /var/lib/apt/lists/*

# Copy the rest of the app
COPY . .

EXPOSE 8000

# Start the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]


