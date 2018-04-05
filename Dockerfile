FROM ubuntu:14.04
MAINTAINER Ash Wilson

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --force-yes \
    apt-transport-https \
#    bash=4.3-6ubuntu1 \
#    libjpeg-turbo8=1.3.0-0ubuntu2 \
#    qemu-system=2.0.0~rc1+dfsg-0ubuntu3 \
#    libminiupnpc8=1.6-3ubuntu2 \
#    dovecot-core=1:2.2.9-1ubuntu2 \
#    libcurl3-nss=7.35.0-1ubuntu2 \
#    apache2-bin=2.4.7-1ubuntu4 \
#    openssl=1.0.1f-1ubuntu2 \
    curl \
    nginx \
    python \
    python-pip

RUN pip install \
    flask \
    cloudpassage \
    pytest

# RUN echo 'deb https://production.packages.cloudpassage.com/debian debian main' | tee /etc/apt/sources.list.d/cloudpassage.list > /dev/null
# RUN curl https://production.packages.cloudpassage.com/cloudpassage.packages.key | apt-key add -
# RUN apt-get update && \
#   apt-get install -y \
#   cphalo

COPY ./ /app/
WORKDIR /app

RUN touch /app/testfile

ENV FLASK_APP=runner.py

EXPOSE 5000

CMD python -m flask run --host=0.0.0.0
