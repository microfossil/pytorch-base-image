FROM nvidia/cuda:11.6.0-runtime-ubuntu20.04

# Inspired by https://github.com/anibali/docker-pytorch/blob/master/dockerfiles/1.10.0-cuda11.3-ubuntu20.04/Dockerfile

# Remove any third-party apt sources to avoid issues with expiring keys.
RUN rm -f /etc/apt/sources.list.d/*.list

# Install some basic utilities
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    sudo \
    git \
    bzip2 \
    libx11-6 \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /app

ENV CONDA_AUTO_UPDATE_CONDA=false
ENV PATH=/app/miniconda/bin:$PATH

# Install conda
RUN curl -sLo /tmp/miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-py39_4.10.3-Linux-x86_64.sh
RUN chmod +x /tmp/miniconda.sh
RUN /tmp/miniconda.sh -b -p /app/miniconda
RUN rm /tmp/miniconda.sh
RUN conda clean -ya

# Install pytorch
RUN conda install pytorch torchvision torchaudio cudatoolkit=11.6 -c pytorch -c conda-forge


