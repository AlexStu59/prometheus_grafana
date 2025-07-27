

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
