# Imagen base ligera
FROM python:3.9-alpine

# Directorio de trabajo
WORKDIR /app

# Copiar archivos
COPY . .

# Instalar dependencias
RUN pip install --no-cache-dir flask

# Exponer puerto
EXPOSE 5000

# Comando de ejecución
CMD ["python", "app.py"]
