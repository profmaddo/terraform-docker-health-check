# 🌐 Projeto Terraform + Docker: Health Check entre Containers

## 🇧🇷 Versão em Português

Este projeto cria dois containers Linux baseados em Alpine usando **Terraform** e **Docker**. Cada container realiza um `ping` para o outro a cada minuto e registra os resultados em arquivos `.txt` salvos localmente.

---

### 🧱 Estrutura Criada

- **Rede personalizada Docker** chamada `ping_network`.
- **2 containers Alpine** (`linux_a` e `linux_b`).
- **Script de health check** via ping entre os containers.
- **Agendamento via cron** para executar o script a cada minuto.
- **Logs** salvos no diretório `logs/` com nomes como:
  - `node_a_yyyymmddhhmmss.txt`
  - `node_b_yyyymmddhhmmss.txt`

---

### 🚀 Requisitos

- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Docker](https://www.docker.com/products/docker-desktop/)

---

### 📦 Como usar

1. Extraia o projeto:
   ```bash
   unzip projeto_ping_docker_terraform.zip
   cd projeto_ping_docker_terraform
   ```

2. Inicialize o Terraform:
   ```bash
   terraform init
   ```

3. Aplique o plano:
   ```bash
   terraform apply
   ```

4. Verifique os logs:
   ```bash
   ls logs/
   tail -f logs/node_a_*.txt
   ```

---

### 🧹 Como remover

```bash
terraform destroy
```

---

## 🇺🇸 English Version

This project uses **Terraform** and **Docker** to create two lightweight Linux containers (based on Alpine). Each container pings the other every minute and logs the results into a `.txt` file stored on the host.

---

### 🧱 Setup Summary

- Custom Docker network called `ping_network`
- Two Alpine-based containers: `linux_a` and `linux_b`
- Health check script using `ping`
- Cron job scheduled to run every minute
- Logs saved to the host in:
  - `logs/node_a_yyyymmddhhmmss.txt`
  - `logs/node_b_yyyymmddhhmmss.txt`

---

### 🚀 Requirements

- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Docker](https://www.docker.com/products/docker-desktop/)

---

### 📦 Usage

1. Extract the project:
   ```bash
   unzip projeto_ping_docker_terraform.zip
   cd projeto_ping_docker_terraform
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Apply the plan:
   ```bash
   terraform apply
   ```

4. Check the logs:
   ```bash
   ls logs/
   tail -f logs/node_a_*.txt
   ```

---

### 🧹 Cleanup

```bash
terraform destroy
```
