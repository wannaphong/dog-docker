FROM gpuci/miniconda-cuda:11.1-base-ubuntu20.04

WORKDIR /workspace
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && apt-get upgrade -y --allow-unauthenticated && \
    apt-get install -y --allow-unauthenticated \
        build-essential \
        cmake \
        curl
RUN conda install -y -c conda-forge tensorflow-gpu faiss pytorch cudatoolkit torchvision


RUN pip --no-cache-dir install \
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

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
