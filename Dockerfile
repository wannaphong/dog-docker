FROM nvidia/cuda:11.7.0-cudnn8-runtime-ubuntu22.04 as base

RUN ["/bin/bash", "-c", "echo I am using bash"]
SHELL ["/bin/bash", "-c"]

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
      python3 \
      python3-dev \
      python-is-python3 \
      python3-pip && \
    apt-get -y autoclean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt-get/lists/*
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && apt-get upgrade -y --allow-unauthenticated && \
    apt-get install -y --allow-unauthenticated \
        build-essential \
        cmake \
        curl && \
    apt-get -y autoclean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt-get/lists/*
RUN python -m pip install --upgrade --no-cache-dir pip setuptools wheel && \
    python -m pip install --no-cache-dir tensorflow torch && \
    python -m pip list

FROM base
# Use C.UTF-8 locale to avoid issues with ASCII encoding
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

WORKDIR /workspace
RUN python -m pip --no-cache-dir install \
        h5py \
        ipykernel \
        jupyter \
        matplotlib \
        numpy \
        pandas \
        Pillow \
        scipy \
        sklearn \
        && \
    python -m ipykernel.kernelspec
# RUN echo I am using the default (/bin/sh)
RUN python -m pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu117
RUN python -m pip install tensorflow

RUN echo I am using bash, which is now the default
ENV SHELL=/bin/bash
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
