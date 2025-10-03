# Usa una imagen base que tenga soporte para Linux
FROM ubuntu:20.04

# Establece el entorno no interactivo para evitar prompts durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Actualiza los paquetes e instala Python y Java
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    openjdk-11-jdk \
    && apt-get clean

# Configura los comandos predeterminados para Python y Java
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# Verifica las versiones instaladas
RUN python --version && java -version

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos necesarios (si los hay)
# ADD . /app

# Comando por defecto (puedes personalizarlo según tus necesidades)
CMD ["bash"]
