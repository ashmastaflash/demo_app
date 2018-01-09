FROM ubuntu:14.04
MAINTAINER Ash Wilson

RUN apt-get update && \
    apt-get install -y --force-yes \
    # bash=4.3-6ubuntu1 \
    apt-transport-https \
    curl \
    nginx \
    python \
    python-pip

RUN pip install \
    flask \
    cloudpassage \
    colorama \
    pytest

RUN echo 'deb https://production.packages.cloudpassage.com/debian debian main' | tee /etc/apt/sources.list.d/cloudpassage.list > /dev/null
RUN curl https://production.packages.cloudpassage.com/cloudpassage.packages.key | apt-key add -
RUN apt-get update && \
    apt-get install -y \
    cphalo

COPY ./ /app/
WORKDIR /app

RUN touch /app/testfile  && rm /app/testfile

ENV FLASK_APP=runner.py

EXPOSE 5000

CMD python -m flask run --host=0.0.0.0
