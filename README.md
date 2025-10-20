# Projeto de Pipeline CI/CD para Microsserviço de Saudações

Este repositório contém a implementação de uma pipeline de Integração Contínua e Entrega Contínua (CI/CD) para um microsserviço em Golang. O projeto automatiza todo o ciclo de vida da entrega, desde a validação do código até a implantação na plataforma de nuvem Koyeb.

![Status da Pipeline](https://github.com/JessicaApBueno/ms-saudacoes/actions/workflows/main.yml/badge.svg)

---

### Visualização da Pipeline

As imagens abaixo ilustram a execução bem-sucedida da pipeline, demonstrando a sequência de etapas automatizadas e os resultados.

<img width="1669" height="729" alt="Captura de tela 2025-10-19 221401" src="https://github.com/user-attachments/assets/7832feb4-be6a-432f-a424-ee1f852582a0" />

<img width="1909" height="897" alt="Captura de tela 2025-10-19 221144" src="https://github.com/user-attachments/assets/00d906bb-60d8-43f3-b95d-780323f1873f" />

<img width="1918" height="674" alt="Captura de tela 2025-10-19 220944" src="https://github.com/user-attachments/assets/40f313b9-51cd-4a22-87e5-ff93e51544b6" />

<img width="1183" height="402" alt="Captura de tela 2025-10-19 193134" src="https://github.com/user-attachments/assets/211156f3-7f89-4312-b11f-04e9059f3f33" />

<img width="1913" height="354" alt="image" src="https://github.com/user-attachments/assets/4aa5195e-dcf3-47a5-b32b-6b77e42e3864" />

<img width="1362" height="404" alt="image" src="https://github.com/user-attachments/assets/75216732-a164-440e-ad64-d1f68bc29c96" />


---

## 🚀 Tecnologias Utilizadas

* **Controle de Versão:** Git e GitHub
* **Orquestrador de CI/CD:** GitHub Actions
* **Contêineres:** Docker e Docker Hub
* **Plataforma de Nuvem (PaaS):** Koyeb
* **Infraestrutura como Código (IaC):** Terraform
* **Linguagem da Aplicação:** Golang

---

## ⚙️ Etapas da Pipeline de CI/CD

A pipeline, definida no arquivo `.github/workflows/main.yml`, foi estruturada nas seguintes etapas para garantir qualidade, consistência e segurança.

#### 1. Verificação e Qualidade do Código (CI)
* **`lint`**: Valida a qualidade do código Go com `go fmt`, `go vet` e `golangci-lint`, garantindo a padronização e prevenindo erros comuns.
* **`test`**: Executa os testes automatizados da aplicação para garantir que novas alterações não quebrem funcionalidades existentes.

#### 2. Empacotamento da Aplicação
* **`build-and-push`**: Se os testes e o lint passarem, este job cria um pacote padronizado da aplicação.
    * **Login no Docker Hub:** Autentica-se de forma segura no Docker Hub usando secrets.
    * **Build da Imagem Docker:** Cria uma imagem Docker a partir do `Dockerfile`, contendo a aplicação compilada e todas as suas dependências.
    * **Push para o Docker Hub:** Publica a imagem no Docker Hub, tornando-a disponível para a implantação.

#### 3. Implantação em Produção (CD)
* **`deploy`**: Implanta a versão mais recente da aplicação no Koyeb.
    * **Execução do Terraform:** Utilizando o `KOYEB_TOKEN`, o Terraform se conecta à conta do Koyeb e, com base nos arquivos da pasta `infra`, provisiona ou atualiza os recursos necessários para rodar a imagem Docker publicada.

#### 4. Limpeza da Infraestrutura (Manual)
* **`cleanup`**: Este job, acionado manualmente, executa `terraform destroy` para remover todos os recursos criados no Koyeb. É uma etapa fundamental para o gerenciamento de custos e limpeza de ambientes.

---

## 🏛️ Cultura DevOps em Ação

Este projeto aplica os seguintes princípios da cultura DevOps:

* **Automação:** Eliminamos o processo de deploy manual, tornando a entrega rápida, repetível e confiável.
* **Integração Contínua (CI):** Cada `push` dispara testes e validações, fornecendo feedback rápido e garantindo a saúde do código na branch principal.
* **Entrega Contínua (CD):** A pipeline entrega e implanta automaticamente o código validado, garantindo que a branch `main` esteja sempre em um estado pronto para produção.
* **Infraestrutura como Código (IaC):** Usamos o Terraform para versionar e gerenciar a infraestrutura, garantindo consistência e transparência.
* **Colaboração e "Shift Left":** A pipeline quebra os silos entre Dev e Ops, trazendo a responsabilidade sobre a qualidade e a implantação para mais perto do desenvolvimento.
* **Segurança (DevSecOps):** Credenciais sensíveis são gerenciadas de forma segura através do uso de **GitHub Secrets**, prevenindo a exposição de chaves e senhas no código.

---

## 🛠️ Configuração do Ambiente

Para que esta pipeline funcione em seu próprio repositório, é necessário configurar os seguintes **Secrets** nas configurações do repositório (`Settings > Secrets and variables > Actions`):

| Secret              | Descrição                                                                       | Exemplo                         |
| ------------------- | ------------------------------------------------------------------------------- | ------------------------------- |
| `DOCKER_USER`       | Seu nome de usuário do Docker Hub (em letras minúsculas).                         | `johndoe`                       |
| `DOCKER_PASS`       | Sua senha ou, preferencialmente, um Token de Acesso do Docker Hub.                | `dckr_pat_...` ou `MyPassword`  |
| `KOYEB_TOKEN`       | Um Token de Acesso gerado na sua conta do Koyeb para autenticação da API.         | `fylu4et9i...`                  |

---

## ▶️ Como Executar

1.  **Deploy Automático:** A pipeline é acionada automaticamente ao fazer um `git push` para a branch `main`.
2.  **Destruição da Infraestrutura (Manual):**
    * Vá para a aba **Actions** do repositório.
    * Selecione a pipeline **"CI/CD - Oi, Sumido Soluções Criativas"** na barra lateral.
    * Clique no botão **"Run workflow"** e confirme a execução. 

<hr>

# API de Saudações Aleatórias

Este é um simples microserviço RESTful construído em Go que fornece saudações aleatórias e permite o cadastro de novas saudações.

## ✨ Funcionalidades

  * Obter uma saudação aleatória do banco de dados.
  * Cadastrar uma nova saudação.
  * Utiliza o framework Gin para o roteamento e gerenciamento das requisições HTTP.
  * Usa GORM como ORM para interagir com o banco de dados.
  * Utiliza SQLite como banco de dados, que é criado e populado automaticamente na primeira execução.
  * O ambiente de desenvolvimento é gerenciado pelo Devbox.

## 🛠️ Tecnologias Utilizadas

  * **Go (Golang)**: Linguagem de programação principal.
  * **Gin**: Framework web para Go.
  * **GORM**: ORM para Go.
  * **SQLite**: Banco de dados SQL embarcado.
  * **Devbox**: Ferramenta para criar ambientes de desenvolvimento isolados.

## 🚀 Como Executar o Projeto

### Pré-requisitos

Antes de começar, você precisa ter o [Devbox](https://www.google.com/search?q=https://www.jetify.com/devbox/docs/installing-devbox/) instalado em sua máquina.

### Passos

1.  **Clone o repositório:**

    ```bash
    git clone <URL_DO_SEU_REPOSITORIO>
    cd ms-saudacoes-aleatorias
    ```

2.  **Inicie o ambiente Devbox:**
    O Devbox instalará automaticamente o Go na versão especificada no arquivo `devbox.json`.

    ```bash
    devbox shell
    ```

3.  **Execute a aplicação:**
    Este comando irá iniciar o servidor na porta `8080`.

    ```bash
    go run main.go
    ```

Ao iniciar, a aplicação criará um arquivo de banco de dados chamado `greetings.db` e o populará com uma lista inicial de saudações.

## 📖 API Endpoints

A API possui o prefixo `/api`.

### Obter uma Saudação Aleatória

Retorna uma saudação aleatória do banco de dados.

  * **Método:** `GET`
  * **Endpoint:** `/api/saudacoes/aleatorio`
  * **Resposta de Sucesso (200 OK):**
    ```json
    {
      "saudação": "Que a Força esteja com você"
    }
    ```
  * **Exemplo com cURL:**
    ```bash
    curl http://localhost:8080/api/saudacoes/aleatorio
    ```

### Cadastrar uma Nova Saudação

Adiciona uma nova saudação ao banco de dados.

  * **Método:** `POST`
  * **Endpoint:** `/api/saudacoes`
  * **Corpo da Requisição (JSON):**
    O campo `text` é obrigatório.
    ```json
    {
      "text": "Sua nova saudação aqui"
    }
    ```
  * **Resposta de Sucesso (201 Created):**
    ```json
    {
      "data": {
        "ID": 10,
        "CreatedAt": "2024-05-18T16:05:23.038166-03:00",
        "UpdatedAt": "2024-05-18T16:05:23.038166-03:00",
        "DeletedAt": null,
        "Text": "Sua nova saudação aqui"
      }
    }
    ```
  * **Exemplo com cURL:**
    ```bash
    curl -X POST \
      -H "Content-Type: application/json" \
      -d '{"text":"Live long and prosper"}' \
      http://localhost:8080/api/saudacoes
    ```
