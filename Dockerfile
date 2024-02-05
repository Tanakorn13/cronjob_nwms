FROM debian:sid

# Use a valid Debian Sid repository mirror
RUN echo 'deb http://deb.debian.org/debian sid main contrib non-free' > /etc/apt/sources.list

RUN apt update && apt upgrade -y
RUN apt-get install tzdata -y
RUN apt install -y python3 python3-dev python3-pip python3-venv cron

RUN python3 -m venv /venv
ENV PYTHON=/venv/bin/python3
RUN $PYTHON -m pip install poetry

WORKDIR /CronJob

COPY poetry.lock pyproject.toml /CronJob/
RUN $PYTHON -m poetry config virtualenvs.create false && $PYTHON -m poetry install --no-interaction --only main

COPY . /CronJob

RUN chmod 0644 crontab

RUN crontab crontab

CMD ["cron","-f", "-l", "2"]