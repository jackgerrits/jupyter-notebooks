FROM python:3.7-slim
# install the notebook package
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook

RUN apt update && apt install -y libboost-dev libboost-program-options-dev libboost-system-dev \
 libboost-thread-dev libboost-math-dev libboost-test-dev zlib1g-dev cmake g++ libboost-python-dev \
 && apt-get clean autoclean \
 && apt-get autoremove -y \
 && rm -rf /var/lib/{apt,dpkg,cache,log}

RUN pip install --no-cache vowpalwabbit

# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}

