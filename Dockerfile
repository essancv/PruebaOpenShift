# Usar Python 3.13 como base
FROM python:3.13-slim

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar los archivos del proyecto
COPY . /app

# Instalar las dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Comando por defecto
CMD ["python"]
