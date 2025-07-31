FROM python:3.12-slim AS build

RUN apt update && \
    apt install git \ 
                build-essential \
                libopenblas-dev \
                gfortran \
                cmake \
                g++ \
                pkg-config -y && \
    apt upgrade -y

WORKDIR /
RUN git clone https://github.com/Qiskit/qiskit-aer.git && \
    cd qiskit-aer && \
    git reset --hard fa271c7cffc0b05e6628809139e0fb695724194 

ENV OMP_NUM_THREADS=1
ENV OMP_THREAD_LIMIT=1
ENV OMP_DYNAMIC=FALSE

WORKDIR /qiskit-aer
RUN pip install setuptools qiskit==1.3.2 cmake conan scikit-build

ENV CONAN_USER_HOME_SHORT=None
RUN python ./setup.py bdist_wheel --build-type=Debug && \
    pip install -U dist/qiskit_aer*.whl

CMD ["python", "-c", "import qiskit_aer; print(qiskit_aer.__version__)"]
