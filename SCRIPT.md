# 🛠️ Terraform + Docker + Cron Health Check — Technical Walkthrough

This project simulates two **Linux microservices** using **Docker containers**, orchestrated via **Terraform**, which perform mutual `ping` health checks every minute using `cron` and store logs with timestamped filenames.

---

## 📁 `main.tf` — Infrastructure as Code

This is the heart of the project. It defines:

### 🔌 Docker Provider

```hcl
provider "docker" {}
```

> Declares Docker as the infrastructure provider.

### 🕸️ Custom Docker Network

```hcl
resource "docker_network" "custom_net" {
  name = "ping_network"
}
```

> Enables container-to-container communication via a shared virtual network.

### 📦 Alpine Linux Image

```hcl
resource "docker_image" "alpine" {
  name = "alpine:latest"
}
```

> Pulls the lightweight Alpine Linux image.

### 🖥️ `linux_a` and `linux_b` Containers

These blocks instantiate the containers. Each:

- Joins the custom Docker network
- Mounts a shared log directory
- Installs `ping` and `crond`
- Sets up a cron job to run `ping.sh` every minute
- Logs results with timestamps to `/logs`

### 🧠 Cron Setup Sample

```hcl
echo '* * * * * /ping.sh linux_b >> /logs/node_a_$(date +\%Y\%m\%d\%H\%M\%S).txt' | crontab -
```

---

## 📜 `ping.sh` — Health Check Script

```bash
#!/bin/sh

TARGET="$1"
LOG_TIME=$(date '+%Y-%m-%d %H:%M:%S')

if ping -c 1 "$TARGET" > /dev/null 2>&1; then
  echo "$LOG_TIME - Ping to $TARGET: OK"
else
  echo "$LOG_TIME - Ping to $TARGET: FAILED"
fi

```

This script:
- Accepts a target host name
- Sends one ping packet
- Logs the result and timestamp to a file

---

## 📊 Sample Output

```
2025-05-08 15:00:00 - Ping to linux_b: OK
2025-05-08 15:01:00 - Ping to linux_b: FAILED
```

---

## ✅ Why This Matters

- Emulates pod-to-pod health checks
- Fully automated using Terraform and Docker
- Realistic for teaching, testing, and PoCs
- Can scale to more containers or protocols
- Extensible to observability or alerting

---

# 🛠️ Explicação Didática do Projeto Terraform + Docker + Cron Health Check (🇧🇷)

Este projeto simula dois **microserviços Linux** usando **containers Docker**, gerenciados com **Terraform**, que executam verificações de saúde (`ping`) programadas a cada minuto com `cron`, registrando os resultados em arquivos `.txt`.

---

## 📁 Arquivo `main.tf` — Definindo a Infraestrutura

Define:

- Provedor Docker para Terraform
- Rede virtual `ping_network`
- Imagem Alpine Linux
- Containers `linux_a` e `linux_b` com volume de logs montado
- Instalação de utilitários e agendamento via `cron`

### 🧠 Exemplo de Agendamento

```hcl
echo '* * * * * /ping.sh linux_b >> /logs/node_a_$(date +\%Y\%m\%d\%H\%M\%S).txt' | crontab -
```

---

## 📜 Script `ping.sh`

```bash
#!/bin/sh

TARGET="$1"
LOG_TIME=$(date '+%Y-%m-%d %H:%M:%S')

if ping -c 1 "$TARGET" > /dev/null 2>&1; then
  echo "$LOG_TIME - Ping to $TARGET: OK"
else
  echo "$LOG_TIME - Ping to $TARGET: FAILED"
fi

```

Recebe o nome do container-alvo e:
- Envia 1 pacote `ping`
- Registra resultado com hora e data no arquivo `.txt`

---

## 📊 Exemplo de Log

```
2025-05-08 15:00:00 - Ping to linux_b: OK
2025-05-08 15:01:00 - Ping to linux_b: FAILED
```

---

## ✅ Por que isso é útil?

- Simula comunicação entre serviços (como pods)
- Automatizado com Terraform + Docker
- Logs persistentes fora dos containers
- Ideal para PoCs, ensino e monitoramento

---

## 📂 Estrutura Final

```
projeto_ping_docker_terraform/
├── main.tf
├── ping.sh
├── logs/
└── README.md
```