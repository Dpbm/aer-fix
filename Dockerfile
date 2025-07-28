FROM --platform=$BUILDPLATFORM python:3.12.11-bullseye AS build

RUN apt update && \
    apt install git build-essential libopenblas-dev -y && \
    apt upgrade -y

WORKDIR /
RUN git clone https://github.com/Qiskit/qiskit-aer.git && \
    cd qiskit-aer && \
    git reset --hard fa271c7cffc0b05e6628809139e0fb695724194 

ENV OMP_NUM_THREADS=1
ENV OMP_THREAD_LIMIT=1
ENV OMP_DYNAMIC=FALSE

WORKDIR /qiskit-aer
RUN pip install .

CMD ["pyhton", "-c", "import qiskit_aer;print(qiskit_aer.__version__)"]
