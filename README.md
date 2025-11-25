# AIS2API - AI Service to API Gateway

[//]: # (English Version)

[![Build and Push to GHCR](https://github.com/Windla/ais2api/actions/workflows/ghcr-publish.yml/badge.svg)](https://github.com/Windla/ais2api/actions/workflows/ghcr-publish.yml)

An application designed to serve AI models, powered by Camoufox for browser automation, and containerized with Docker for easy deployment. This project is automatically built and pushed to the GitHub Container Registry (GHCR) via GitHub Actions.

## ✨ Features

- **AI Model Serving**: Provides a unified server to interact with AI models.
- **Browser Automation**: Utilizes Camoufox, a privacy-focused version of Firefox, for browser-related tasks.
- **Containerized**: Packaged as a Docker image for consistent and isolated environments.
- **CI/CD**: Automated build and push pipeline to GHCR using GitHub Actions.

## 🚀 How to Run

You can run this application using the pre-built Docker image from GHCR.

1.  **Log in to GHCR:**
    ```bash
    echo $CR_PAT | docker login ghcr.io -u YOUR_GITHUB_USERNAME --password-stdin
    ```
    (Replace `YOUR_GITHUB_USERNAME` with your GitHub username and use a Personal Access Token with `read:packages` scope as `CR_PAT`)

2.  **Pull the Docker Image:**
    ```bash
    docker pull ghcr.io/windla/ais2api:latest
    ```

3.  **Run the Container:**
    ```bash
    docker run -d -p 7860:7860 -p 9998:9998 --name ais2api ghcr.io/windla/ais2api:latest
    ```

The service will be available at `http://localhost:7860`.

---

[//]: # (Chinese Version)

# AIS2API - AI 服务 API 网关

[![构建并推送到 GHCR](https://github.com/Windla/ais2api/actions/workflows/ghcr-publish.yml/badge.svg)](https://github.com/Windla/ais2api/actions/workflows/ghcr-publish.yml)

一个旨在提供 AI 模型服务的应用程序，由 Camoufox 提供浏览器自动化能力，并使用 Docker 进行容器化以便于部署。该项目通过 GitHub Actions 自动构建并推送到 GitHub Container Registry (GHCR)。

## ✨ 功能特性

- **AI 模型服务**：提供一个统一的服务器来与 AI 模型进行交互。
- **浏览器自动化**：利用注重隐私的 Firefox 版本 Camoufox 来执行与浏览器相关的任务。
- **容器化**：打包为 Docker 镜像，以实现一致和隔离的运行环境。
- **CI/CD**：使用 GitHub Actions 实现自动构建并推送到 GHCR 的流水线。

## 🚀 如何运行

您可以使用 GHCR 上预构建的 Docker 镜像来运行此应用。

1.  **登录到 GHCR:**
    ```bash
    echo $CR_PAT | docker login ghcr.io -u 你的GitHub用户名 --password-stdin
    ```
    (请将 `你的GitHub用户名` 替换为您的 GitHub 用户名，并使用具有 `read:packages` 权限的个人访问令牌作为 `CR_PAT`)

2.  **拉取 Docker 镜像:**
    ```bash
    docker pull ghcr.io/windla/ais2api:latest
    ```

3.  **运行容器:**
    ```bash
    docker run -d -p 7860:7860 -p 9998:9998 --name ais2api ghcr.io/windla/ais2api:latest
    ```

服务将在 `http://localhost:7860` 上可用。