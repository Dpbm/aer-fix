FROM python:3.12-slim AS build

RUN apt update && \
    apt install git \ 
                build-essential \
                libopenblas-dev \
                gfortran \
                pkg-config -y && \
    apt upgrade -y

WORKDIR /
RUN pip install qiskit==1.3.2 qiskit-aer==0.16.1

CMD ["python", "-c", "import qiskit_aer; print(qiskit_aer.__version__)"]
