#!/bin/bash

# ==========================================================
# Script: setup_env.sh (Versión para Amazon Linux)
# ==========================================================

echo "Iniciando preparación del entorno en Amazon Linux..."

# 1. Actualización de paquetes (usando dnf)
echo "Actualizando paquetes del sistema..."
sudo dnf update -y

# 2. Instalación de herramientas (Git y Python ya suelen estar, pero aseguramos)
echo "Asegurando Git y Python3..."
sudo dnf install git python3-pip -y

# 3. Instalación de Docker
echo "Instalando Docker..."
sudo dnf install docker -y

# 4. Iniciar y habilitar Docker
echo "Iniciando servicio de Docker..."
sudo systemctl start docker
sudo systemctl enable docker

# 5. Permisos (Opcional pero recomendado)
# Esto permite que el usuario ec2-user use docker sin 'sudo'
sudo usermod -aG docker ec2-user

echo "--------------------------------------"
echo "Entorno preparado correctamente."
echo "IMPORTANTE: Si es la primera vez que instalas docker, cierra sesión y vuelve a entrar para aplicar permisos."
