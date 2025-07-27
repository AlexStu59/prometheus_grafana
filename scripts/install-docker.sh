#!/bin/bash
# Script d'installation de Docker pour Debian sous WSL 2

set -e  # Arrête le script en cas d'erreur

# 🛠️ Installation des dépendances nécessaires
sudo apt update && sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# 🧷 Ajout de la clé GPG Docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# 📦 Ajout du dépôt Docker
echo "deb [arch=$(dpkg --print-architecture) \
    signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 🔄 Mise à jour des paquets et installation de Docker
sudo apt update
sudo apt install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

# 👤 Ajout de l'utilisateur au groupe Docker (nécessite une reconnexion)
sudo usermod -aG docker $USER

echo "✅ Docker a été installé avec succès !"
echo "👉 Déconnecte-toi ou lance une nouvelle session pour profiter de Docker sans sudo."
