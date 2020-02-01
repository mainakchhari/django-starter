FROM python:3.7.6-stretch as builder
ENV PYTHONUNBUFFERED 1
RUN apt-get update && apt-get install build-essential
RUN pip install --upgrade pip
WORKDIR /src
ADD requirements.txt /src
RUN pip install -r requirements.txt

FROM builder as webserver
LABEL com.example.version="$VERSION"
WORKDIR /src
ADD ./src /src
CMD python manage.py makemigrations; python manage.py migrate; python manage.py collectstatic --no-input; python manage.py runserver --noreload 0.0.0.0:8000
