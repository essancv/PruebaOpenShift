# Usa una imagen base que tenga soporte para Linux
FROM ubuntu:20.04

# Establece el entorno no interactivo para evitar prompts durante la instalación
ENV DEBIAN_FRONTEND=noninteractive
# Establece el entorno no interactivo para evitar prompts durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Actualiza los paquetes e instala dependencias necesarias para compilar Python y para Java
RUN apt-get update && apt-get install -y \
    wget \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libgdbm-dev \
    libdb5.3-dev \
    libbz2-dev \
    libexpat1-dev \
    liblzma-dev \
    tk-dev \
    libffi-dev \
    uuid-dev \
    openjdk-11-jdk \
    && apt-get clean

# Descarga y compila Python 3.13 desde el código fuente
RUN wget https://www.python.org/ftp/python/3.13.0/Python-3.13.0.tgz && \
    tar xvf Python-3.13.0.tgz && \
    cd Python-3.13.0 && \
    ./configure --enable-optimizations && \
    make -j$(nproc) && \
    make altinstall && \
    cd .. && \
    rm -rf Python-3.13.0 Python-3.13.0.tgz

# Configura los comandos predeterminados para Python y Java
RUN update-alternatives --install /usr/bin/python python /usr/local/bin/python3.13 1

# Verifica las versiones instaladas
RUN python --version && java -version

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos necesarios (si los hay)
# ADD . /app

# Copia el archivo de dependencias (requirements.txt) al contenedor
COPY requirements.txt .

# Actualiza pip y luego instala los paquetes necesarios
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copia el resto de los archivos de la aplicación al contenedor
COPY . .

# Comando por defecto (puedes personalizarlo según tus necesidades)
CMD ["python", "app.py"]
