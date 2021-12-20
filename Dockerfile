FROM gpuci/miniconda-cuda:11.1-base-ubuntu20.04

WORKDIR /workspace
RUN conda install -y pytorch torchvision torchaudio cudatoolkit=11.3 -c pytorch
RUN conda install -y -c conda-forge tensorflow-gpu 


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
