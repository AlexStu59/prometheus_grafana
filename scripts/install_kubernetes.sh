#!/bin/bash
# Script d'installation de Kubernetes (k3s + kubectl) pour Debian sous WSL 2

set -e  # Stoppe en cas d'erreur

# 🔧 Dépendances
sudo apt update && sudo apt install -y \
    curl \
    wget

# 📥 Installation de kubectl (client Kubernetes)
KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

echo "✅ kubectl installé en version : $KUBECTL_VERSION"

# ☸️ Installation de k3s (serveur Kubernetes léger)
curl -sfL https://get.k3s.io | sh -

# 🔁 Ajout du binaire kubectl de k3s (optionnel, pour référence)
sudo ln -s /usr/local/bin/kubectl /usr/bin/kubectl || true

# 🔍 Vérification du nœud
kubectl get nodes

echo "🚀 Kubernetes avec k3s est opérationnel !"
