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

# ☸️ Installation de k3s avec droits sur kubeconfig
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --write-kubeconfig-mode 644" sh -

# 📁 Configuration de kubectl pour k3s
mkdir -p ~/.kube
sudo cat /etc/rancher/k3s/k3s.yaml > ~/.kube/config
sudo chown $USER:$USER ~/.kube/config
chmod 600 ~/.kube/config

# 🧠 Définir KUBECONFIG pour la session en cours
export KUBECONFIG=~/.kube/config

# 🔁 Ajout du binaire kubectl de k3s (optionnel, pour référence)
sudo ln -s /usr/local/bin/kubectl /usr/bin/kubectl || true

# 🔍 Vérification du nœud
kubectl get nodes

echo "🚀 Kubernetes avec k3s est opérationnel et entièrement configuré !"
