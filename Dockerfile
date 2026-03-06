# ===== SAM3 (official facebookresearch/sam3) on CUDA =====
# Requirements (Meta): Python 3.12+, PyTorch 2.7+, CUDA 12.6+
# This image:
# - builds in bash so conda activation is reliable
# - keeps zsh for interactive sessions (when you override command)

FROM pytorch/pytorch:2.7.0-cuda12.6-cudnn9-devel

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

# ---- timezone ----
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone

# ---- install packages ----
#  delete some pkgs, you do *not* need.
RUN apt-get update && apt-get install -y --no-install-recommends \
    git wget curl ca-certificates \
    libgl1 libglib2.0-0 libsm6 libxext6 libxrender1 \
    tzdata locales \
    zsh vim \
    coreutils moreutils \
    direnv sudo \
    vifm \
  && rm -rf /var/lib/apt/lists/*

## for pycoco build, in case pycoco can *not* be builded
#RUN apt-get update && apt-get install -y --no-install-recommends \
#    build-essential pkg-config \
# && rm -rf /var/lib/apt/lists/*


# ---- locale (ja_JP UTF-8): optional ----
RUN sed -i 's/^# *\(ja_JP.UTF-8 UTF-8\)/\1/' /etc/locale.gen \
 && locale-gen

## ---- oh-my-zsh (optional) ----
#RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.2.1/zsh-in-docker.sh)" \
# && sed -i "s/# zstyle ':omz:update' mode disabled/zstyle ':omz:update' mode disabled/g" /root/.zshrc || true
#
## ---- fzf (optional) ----
#RUN git clone --depth 1 https://github.com/junegunn/fzf.git /root/.local/bin/.fzf \
# && /root/.local/bin/.fzf/install --xdg --key-bindings --completion --no-update-rc

# ---- Python 3.12 env ----
WORKDIR /opt
RUN conda create -n sam3 python=3.12 -y \
 && conda clean -a -y

# Use bash for build commands (conda activate is reliable here)
SHELL ["bash", "-lc"]
RUN echo "conda activate sam3" >> /root/.bashrc

# ---- Clone & install SAM3 ----
RUN git clone https://github.com/facebookresearch/sam3.git /opt/sam3
WORKDIR /opt/sam3

## dir-structure 
# /opt/conda
# ├── bin
# ├── envs
# │   └── sam3
# └── pkgs

## PATH
# /opt/conda/envs/sam3/bin/python
# /opt/conda/envs/sam3/bin/pip
# /opt/conda/envs/sam3/bin/jupyter


## Install SAM3 + HF tools + JupyterLab into the sam3 conda env
## install old setuptools for sam3
RUN conda run -n sam3 python -V \
 && conda run -n sam3 pip install --no-cache-dir -U pip \
 && conda run -n sam3 pip uninstall -y setuptools || true \
 && conda run -n sam3 pip install --no-cache-dir setuptools==80.9.0 \
 #&& conda run -n sam3 pip install --no-cache-dir numpy cython \
 && conda run -n sam3 pip install --no-cache-dir numpy \
 && conda run -n sam3 pip install --no-cache-dir -e . \
 && conda run -n sam3 pip install --no-cache-dir -U "huggingface_hub[cli]" \
 && conda run -n sam3 pip install --no-cache-dir -U jupyterlab ipykernel

## install many pkgs later.
RUN conda run -n sam3 pip install --no-cache-dir \
    matplotlib \
    pillow \
    einops \
    opencv-python-headless \
    pandas \
    pycocotools \
    scikit-image \
    scikit-learn \
    scipy \
    fvcore \
    iopath \
    ipywidgets

## decord は失敗しやすいので最後に単独で（失敗してもビルド継続したいなら || true）
## pip install decord でコケたら、後から手動でいれること。
RUN conda run -n sam3 pip install --no-cache-dir decord || true
#RUN conda run -n sam3 pip install --no-cache-dir decord

# ---- HF cache dirs (bind-mount recommended) ----
ENV HF_HOME=/opt/hf
ENV TRANSFORMERS_CACHE=/opt/hf/transformers
ENV HF_HUB_CACHE=/opt/hf/hub

## ---- Your dotfiles / settings (optional) ----
## If you have these, comment them out.
## NOTE:
##  - These COPY steps will fail if the paths don't exist in the build context.
#WORKDIR /root
#RUN mkdir -p /root/bin /root/.config /root/.vifm
#
#COPY ./home/* /root/
#COPY ./home_all/.vifm/* /root/.vifm/
#COPY ./home_all/bin/* /root/bin/
#COPY ./home_all/.config/lf /root/.config/
#
## proxy setting
#RUN mkdir -p /etc/apt
#COPY ./etc/apt/* /etc/apt/

# ---- default workdir ----
WORKDIR /opt/sam3/my_data

## Expose Jupyter port (optional; compose will publish it)
EXPOSE 8888

# Default interactive shell
CMD ["bash"]
#CMD ["zsh"]
