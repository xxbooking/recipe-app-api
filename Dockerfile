FROM python:3.9-alpine3.13
LABEL maintainer="bnbooking.com"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /Users/jm/DevProjects/recipe-app-api/app
WORKDIR /Users/jm/DevProjects/recipe-app-api/app
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py && \
      /py/bin/pip install --upgrade pip && \
      /py/bin/pip install -r /tmp/requirements.txt && \
      if [ $DEV = "true" ]; \
         then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
      fi && \
      rm -rf /tmp && \
      adduser \
         --disabled-password \
         --no-create-home \
         django-user

ENV PATH="/py/bin:$PATH"

USER django-user
