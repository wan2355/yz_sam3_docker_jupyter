# SAM3 Docker + JupyterLab (GPU Ready)

English | [日本語](README.ja.md)

[![Docker](https://img.shields.io/badge/docker-ready-blue)]()
[![CUDA](https://img.shields.io/badge/CUDA-supported-green)]()
[![License](https://img.shields.io/badge/license-MIT-yellow)]()

Run **SAM3** using **Docker + Conda + JupyterLab + GPU**.

------------------------------------------------------------------------

# Features

-   CUDA / GPU support
-   Conda environment (`sam3`)
-   JupyterLab included
-   Hugging Face cache sharing
-   Makefile workflow
-   Optional proxy support
-   create environment by manjaro linux

------------------------------------------------------------------------

# Requirements

Before running this project install:

-   Linux
-   Docker
-   Docker Compose v2
-   NVIDIA Container Toolkit
-   CUDA capable GPU
-   GNU Make (recommended)

Check GPU support:
```
    docker run --rm --gpus all nvidia/cuda:12.1.1-base-ubuntu22.04 nvidia-smi
```

------------------------------------------------------------------------

# Repository Structure

    sam3-docker
    ├ Dockerfile
    ├ docker-compose.yml
    ├ Makefile
    ├ README.md
    ├ LICENSE
    ├ .env_example
    ├ .gitignore
    ├ .dockerignore

------------------------------------------------------------------------

# Quick Start

## 1 Clone this repository

```
    git clone https://github.com/wan2355/yz_sam3_docker_jupyter.git
    cd yz_sam3_docker_jupyter
    make build
    make jupyter
```

------------------------------------------------------------------------

## 2 Optional proxy configuration, if you need

```
    cp .env_sample .env
```

Edit if needed:

    HTTP_PROXY=
    HTTPS_PROXY=
    NO_PROXY=

If you do not use a proxy you can skip this step.

------------------------------------------------------------------------

# Makefile system

comand help

```
make help

make build   : build Docker image
make up      : run foreground
make upd     : run background
make down    : stop container
make restart : restart container
make logs    : follow compose logs
make ps      : container status
make bash    : login bash
make zsh     : login zsh
make jupyter : sam3 container logs
make network : docker network list
make prune   : delete unused network
make clean   : stop container + network prune
```



------------------------------------------------------------------------

# Build Docker Image

```
    make build
```

This builds the Docker image:

```
    sam3:latest
```

------------------------------------------------------------------------

# Start Container + JupyterLab
```
    make jupyter
```
or
```
    make upd
```

Then open:

    http://localhost:8888

Token authentication is required.
Check the token in the docker log:

```
docker logs sam3
```

------------------------------------------------------------------------

# Stop Container

```
    make down

```
------------------------------------------------------------------------

# Container Shell

```
    make bash

```
or

```
    make zsh
```

------------------------------------------------------------------------

# Run Jupyter with logs

```
    make jupyter
```

------------------------------------------------------------------------

# Docker Image Operations

Save container as image:

```
    docker commit "container_name" "image_name"
```

Rename image:

```
    docker tag "image_name" "new_name"
```

Delete image:

```
    docker rmi "image_name"
```

------------------------------------------------------------------------

# Hugging Face Cache

Large model files are reused from your local machine.

    $HOME/.cache/huggingface → /opt/hf

This prevents re‑downloading model weights.

------------------------------------------------------------------------

# Working Directory

Inside the container:

    /opt/sam3

Your project folder is mounted at:

    /opt/sam3/my_data

------------------------------------------------------------------------

# Notes

Many research repositories (including SAM projects) have incomplete
dependency definitions.

This container provides:

-   deterministic environment
-   dependency isolation
-   reproducible experiments

------------------------------------------------------------------------

# License

MIT License
