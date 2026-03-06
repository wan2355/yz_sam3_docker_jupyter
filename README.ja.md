
# SAM3 Docker + JupyterLab (GPU Ready)

[English](README.md) | 日本語

このリポジトリは **SAM3 を Docker + Conda + JupyterLab 環境で実行するための環境**を提供します。

ただし、利用環境によっては上手く動作しない可能性もあります。

---

# 特徴

- CUDA / GPU 対応
- Conda 環境 (`sam3`)
- JupyterLab
- Hugging Face cache 共有
- Makefile による操作
- manjaro linux で環境を構築

---

# 必要環境

以下が必要です。

- Linux
- Docker
- Docker Compose v2
- NVIDIA Container Toolkit
- CUDA 対応 GPU
- Make（推奨）

GPU が使えるか確認するには：

```
docker run --rm --gpus all nvidia/cuda:12.1.1-base-ubuntu22.04 nvidia-smi
```

---

# 使い方

## 1 リポジトリを clone

```
git clone https://github.com/YOUR_NAME/yz_sam3_docker_jupyter.git
cd yz_sam3_docker_jupyter
make build
make jupyter
```

---

## 2 Docker image build

```
make build
```

---

## 3 Jupyter 起動

```
make jupyter
```

ブラウザで次を開きます：

```
http://localhost:8888
```

Jupyter の token は docker log に表示されます。

```
docker logs sam3
```

---

# コンテナ停止

```
make down
```

---

# Makefile コマンド

利用可能なコマンドを表示

```
make help
```

よく使うワークフロー

```
make build
make upd
make logs
make bash
make down
```

---

# コンテナ shell

```
make bash
```

または

```
make zsh
```

---

# Jupyter ログ

```
make jupyter
```

---

# Docker Image 操作

コンテナを image として保存

```
docker commit "container_name" "image_name"
```

image の rename

```
docker tag "image_name" "new_name"
```

image 削除

```
docker rmi "image_name"
```

---

# Hugging Face cache

大きなモデルファイルはローカルの cache を共有します。

```
$HOME/.cache/huggingface → /opt/hf
```

これによりモデルの再ダウンロードを防ぎます。

---

# 作業ディレクトリ

コンテナ内

```
/opt/sam3
```

ローカル作業ディレクトリ

```
/opt/sam3/my_data
```

---


# License

MIT License
