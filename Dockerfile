# Etapa 1: Construção
FROM python:3.9-slim AS builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --user -r requirements.txt

COPY . .

RUN python -m pytest
RUN flake8 main.py
RUN bandit -r .

# Etapa 2: Construção da Imagem Final
FROM python:3.9-slim

WORKDIR /app

COPY --from=builder /app /app

CMD ["python", "main.py"]
