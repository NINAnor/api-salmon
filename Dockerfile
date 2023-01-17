FROM python:3.8-slim

RUN pip install pdm

WORKDIR /app
COPY pyproject.toml pdm.lock ./
RUN pdm install --production --no-self && \
    sed -i '1s;.*;#!/usr/bin/env python3;' $(pdm run which hug)

COPY app.py .

CMD ["pdm", "run", "hug", "-f", "app.py", "--bind", "0.0.0.0:8050"]
