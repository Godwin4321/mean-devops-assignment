# 🚀 MEAN Stack Application — Containerization & CI/CD Deployment

Loom: https://www.loom.com/share/4dbe6a102a2a40f88b1b543ca14ec040

---

# 📌 Project Overview

This project demonstrates the containerization and automated deployment of a full‑stack **MEAN (MongoDB, Express, Angular, Node.js)** application using modern DevOps practices.

The application is:

- Fully Dockerized
- Deployed on AWS EC2
- Integrated with CI/CD
- Automatically built & deployed on every push

---

# 🧱 Tech Stack

| Layer | Technology |
|------|-------------|
| Frontend | Angular |
| Backend | Node.js + Express |
| Database | MongoDB |
| Reverse Proxy | Nginx |
| Containerization | Docker |
| Orchestration | Docker Compose |
| CI/CD | GitHub Actions |
| Cloud | AWS EC2 (Ubuntu 22.04) |
| IaC | Terraform |

---

# 🏗️ Architecture Flow

```
GitHub → GitHub Actions → Docker Hub → EC2 → Docker Compose

Browser → Nginx → Frontend / Backend → MongoDB
```

---

# ⚙️ Infrastructure Provisioning

Provisioned via Terraform:

- EC2 (t2.small)
- Security Group (22, 80)
- Elastic IP
- IAM Role
- User‑data bootstrap

---

# 🐳 Containerization

| Service | Container |
|--------|-------------|
| Frontend | Angular + Nginx |
| Backend | Node API |
| Database | MongoDB |
| Proxy | Nginx |

Persistent storage via Docker volumes.

---

# 🔁 CI/CD Pipeline

Triggered on push to `main`.

Steps:

1. Checkout code
2. Docker Hub login
3. Build backend image
4. Push backend image
5. Build frontend image
6. Push frontend image
7. SSH into EC2
8. Pull images
9. Restart containers

---

# 🖥️ Local Setup

## Verify Docker

```bash
docker --version
docker compose version
```

---

# 📂 Project Structure

```
backend/
frontend/
nginx/
docker-compose.yml
terraform/
```

---

# 🐳 Backend Dockerfile

```
FROM node:18-alpine

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

EXPOSE 8080
CMD ["node","server.js"]
```

---

# 🐳 Angular Multi‑Stage Dockerfile

```
FROM node:18-alpine AS build

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --prod

FROM nginx:alpine
COPY --from=build /app/dist/angular-15-crud /usr/share/nginx/html

EXPOSE 80
CMD ["nginx","-g","daemon off;"]
```

---

# 🌐 Nginx Reverse Proxy

```
events {}

http {
  server {
    listen 80;

    location / {
      proxy_pass http://frontend:80;
    }

    location /api/ {
      proxy_pass http://backend:8080/api/;
    }
  }
}
```

---

# 🧩 Full Stack Compose

```
version: "3.9"

services:

  mongo:
    image: mongo:6
    volumes:
      - mongo_data:/data/db

  backend:
    image: godwin9153/mean-backend:latest
    environment:
      - MONGO_URL=mongodb://mongo:27017/dd_db
    depends_on:
      - mongo

  frontend:
    image: godwin9153/mean-frontend:latest
    depends_on:
      - backend

  nginx:
    build: ./nginx
    ports:
      - "80:80"
    depends_on:
      - frontend
      - backend

volumes:
  mongo_data:
```

---

# ☁️ Terraform Deployment

Initialize & deploy:

```bash
terraform init
terraform plan
terraform apply
```

---

# 🔑 GitHub Secrets

Add:

```
DOCKERHUB_USERNAME
DOCKERHUB_TOKEN
EC2_HOST
EC2_SSH_KEY
```

---

# 🏁 Final Outcome

- Dockerized MEAN stack
- Reverse proxy routing
- Persistent DB
- Terraform infra
- Automated CI/CD

Production‑ready deployment 🚀