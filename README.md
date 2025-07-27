

```markdown
# 🧪 DevOps Monitoring Lab – Prometheus & Grafana

Ce dépôt contient l'ensemble des fichiers nécessaires pour déployer une stack de monitoring local basée sur Prometheus, Grafana, et divers exporters, conteneurisés via Docker Compose.

---

## 📦 Contenu du projet

- `docker-compose.yml` : stack de conteneurs Prometheus, Grafana, Node Exporter...
- `prometheus.yml` : configuration du scraping des métriques
- `grafana/provisioning/` : provisioning automatique des datasources et dashboards
- `dashboards/` : JSON des dashboards exportés depuis Grafana
- `scripts/setup.sh` : script pour installer et lancer toute la stack
- `.env` : variables d'environnement (si nécessaire)
- `.gitignore` : exclusions des fichiers temporaires/logs

---

## 🚀 Installation rapide

```bash
git clone https://github.com/<ton-user>/<nom-du-repo>.git
cd <nom-du-repo>
./scripts/setup.sh
```

ou manuellement :

```bash
docker-compose up -d
```

---

## 📊 Accès à Grafana

- URL : `http://localhost:3000`
- Identifiants :
  - utilisateur : `admin`
  - mot de passe : `admin` (à changer !)

---

## 🧠 Exporters configurés

| Exporter        | Port exposé | Description                 |
|----------------|-------------|-----------------------------|
| Node Exporter  | `9100`      | métriques système           |
| Blackbox       | `9115`      | tests HTTP/ICMP externes    |
| ...            | ...         | à compléter selon ton setup |

---

## 📍 Roadmap

- [x] Déploiement local avec Docker Compose
- [ ] Migration vers Kubernetes
- [ ] Monitoring multi-cluster via VPN
- [ ] Intégration Thanos / Cortex (optionnel)

---

## 🛡️ Sécurité

- Réseau local pour débuter
- Possibilité d’ajout d’un VPN pour le scraping inter-machines
- Authentification à prévoir pour Grafana si exposé

---

## 📚 Formation & démonstration

Ce repo est pensé pour être **cloné et lancé facilement** dans le cadre d’une formation technique, démonstration en présentiel, ou réplication d’environnement chez soi.

---

## 🙌 Contribution

N’hésite pas à améliorer les dashboards, ajouter des exporters ou automatiser encore plus le setup !

---

---

## ⚙️ 1. Cohérence entre Docker et Kubernetes

### 🧩 Tu dois t’assurer que :
- Les **noms des images Docker** utilisées dans les manifests (`deployment.yaml`) correspondent **exactement** à celles qui sont disponibles dans ton registre Docker (local ou distant).
- Les **ports exposés** dans Docker doivent être aussi définis dans `containerPort` des manifests.
- Les **volumes ou données persistées** doivent être traduits par des `volumeMounts` et `volumes`.

---

## 📦 2. Étapes pour créer et utiliser l’image Docker

### 🏗️ A. Construire ton image
Ton Dockerfile peut ressembler à ça (exemple Grafana modifié) :

```Dockerfile
FROM grafana/grafana:latest
COPY provisioning/ /etc/grafana/provisioning/
```

```bash
docker build -t grafana-custom:latest .
```

### 📍 B. Pousser l’image dans le registre local de k3s
```bash
docker tag grafana-custom localhost:5000/grafana-custom:latest
docker push localhost:5000/grafana-custom:latest
```

### ✅ C. Vérifier que ton image est disponible
```bash
curl http://localhost:5000/v2/_catalog
```

Tu dois voir `grafana-custom` dans la liste.

---

## 📄 3. Rédiger les manifests Kubernetes

### A. `Deployment` → référence ton image
```yaml
containers:
- name: grafana
  image: localhost:5000/grafana-custom:latest
  ports:
  - containerPort: 3000
```

### B. `Service` → expose ton app
```yaml
spec:
  ports:
  - port: 80
    targetPort: 3000
```

---

## 📋 4. Ordre de lancement des fichiers

Voici l’ordre **idéal** pour déployer proprement :

| Étape | Manifest / Action                  | Description                                      |
|-------|------------------------------------|--------------------------------------------------|
| 1️⃣    | `prometheus-config.yaml`           | Crée le ConfigMap utilisé par Prometheus         |
| 2️⃣    | `prometheus-deployment.yaml`       | Déploie le serveur Prometheus                    |
| 3️⃣    | `prometheus-service.yaml`          | Permet à Grafana de se connecter à Prometheus    |
| 4️⃣    | `grafana-deployment.yaml`          | Déploie Grafana avec ton image personnalisée     |
| 5️⃣    | `grafana-service.yaml`             | Ouvre l’accès via NodePort (http://IP:PORT)      |

👉 Tu peux appliquer chaque fichier avec :

```bash
kubectl apply -f nom-du-fichier.yaml
```

---

## 🧠 Bonus : Vérifie après chaque étape

- `kubectl get pods` → tous les pods doivent être `Running`
- `kubectl get svc` → note le `NodePort` pour accéder à Grafana
- Accède à Grafana, ajoute Prometheus comme datasource avec `http://prometheus:9090`

---

