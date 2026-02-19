# 🚀 POC – n8n na AWS com Terraform

![Terraform](https://img.shields.io/badge/Terraform-1.5+-623CE4?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-Cloud-FF9900?logo=amazonaws)
![Docker](https://img.shields.io/badge/Docker-Container-2496ED?logo=docker)
![Architecture](https://img.shields.io/badge/Architecture-2--Tier-blue)
![Status](https://img.shields.io/badge/Status-Conclu%C3%ADdo-success)

---

## 🎓 Contexto

Projeto desenvolvido como parte da **Formação AWS – Ciclo 3**, com o objetivo de aplicar conceitos de:

- Infraestrutura como Código
- Arquitetura em camadas
- Segurança básica em nuvem
- Provisionamento automatizado

---

# 🎯 Objetivo da POC

Implementar uma arquitetura segura para execução do **n8n** na AWS, utilizando Terraform para provisionamento completo da infraestrutura.

---

# 🧠 Conceito Arquitetural

A arquitetura segue o modelo **2-Tier (duas camadas)**:

- Camada Pública → Load Balancer
- Camada Privada → EC2 rodando n8n

Isso garante:

✅ Separação de responsabilidades  
✅ Redução de superfície de ataque  
✅ Organização da infraestrutura  
✅ Base para escalabilidade futura  

---

# 🏗️ Arquitetura Implementada

## ☁️ Serviços AWS Utilizados

- VPC customizada
- Subnet Pública
- Subnet Privada
- Internet Gateway
- Application Load Balancer (ALB)
- Target Group
- EC2 (Amazon Linux 2)
- IAM Role
- AWS Systems Manager (SSM)
- Security Groups

---

# 🌐 Fluxo da Aplicação

Internet
↓
ALB (HTTP 80)
↓
Target Group
↓
EC2 Privada (porta 5678)
↓
Docker
↓
n8n


---

# 🔐 Estratégia de Segurança

- ❌ EC2 sem IP público
- ❌ Porta 22 (SSH) não exposta
- ✅ Acesso administrativo via Session Manager (SSM)
- ✅ Security Group da EC2 aceita tráfego apenas do ALB
- ✅ Separação entre subnet pública e privada

---

# 📂 Estrutura do Projeto

├── main.tf
├── variables.tf
├── terraform.tfvars
├── network.tf
├── security.tf
├── ec2.tf
├── alb.tf
├── outputs.tf

---

# ⚙️ Como Executar

### 1️⃣ Inicializar Terraform

```bash
1. terraform init
2. terraform plan
3. terraform apply

📊 Aprendizados Aplicados

Durante a construção da POC foram aplicados os seguintes conceitos:

Criação de VPC customizada

Separação de subnets

Configuração de Security Groups

Uso de IAM Role para SSM

Deploy automatizado via Terraform

Containerização com Docker

Integração com Application Load Balancer

⚠️ Pontos de Atenção

Subnet privada necessita NAT Gateway para acesso externo

Health check do ALB deve estar corretamente configurado

IAM Role é obrigatória para funcionamento do SSM

Monitorar custos após provisionamento

🚀 Próximas Evoluções

Implementar NAT Gateway

Migrar para HTTPS com ACM

Criar Auto Scaling Group

Modularizar Terraform

Implementar monitoramento com CloudWatch

🎓 Conclusão

Esta POC demonstra aplicação prática de:

✔ Infraestrutura como Código
✔ Arquitetura em Camadas
✔ Segurança básica em Cloud
✔ Provisionamento automatizado
✔ Boas práticas iniciais AWS

👩‍💻 Autora

Ana Paula
Formação AWS – Ciclo 3

