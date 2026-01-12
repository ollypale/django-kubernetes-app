FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# system deps for psycopg2 (обычно достаточно, но psycopg2-binary уже включает всё нужное)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
  && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/

EXPOSE 8000

# Запускаем через gunicorn (прод-стиль)
CMD ["gunicorn", "config.wsgi:application", "--bind", "0.0.0.0:8000"]
