
# SAM3 Docker + JupyterLab (GPU Ready)

[English](README.md) | 日本語

このリポジトリは **SAM3 を Docker + Conda + JupyterLab 環境で実行するための環境**を提供します。

Python の依存関係問題を避け、再現可能な環境で SAM3 を実行できます。

---

# 特徴

- Docker による再現可能な環境
- CUDA / GPU 対応
- Conda 環境 (`sam3`)
- JupyterLab
- Hugging Face cache 共有
- Proxy 環境対応
- Makefile による簡単操作

---

# 必要環境

以下が必要です。

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

# Notes

SAM 系リポジトリは dependency が完全に定義されていないことが多く、
環境構築が難しい場合があります。

この Docker 環境は

- 再現可能な環境
- 依存関係の分離
- 安定した実験環境

を提供します。

---

# License

MIT License
