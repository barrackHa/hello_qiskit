FROM ubuntu:16.04

USER root

RUN apt-get update && apt-get install -y wget bzip2 unzip \
    && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh \
    && bash ~/miniconda.sh -b -p /miniconda \
    && rm -f ~/miniconda.sh \
    && export PATH=$PATH:/miniconda/bin \
    && /miniconda/bin/conda install jupyter scipy matplotlib \
    && mkdir /notebook

RUN /miniconda/bin/pip3 install qiskit pylatexenc

# Install file type convertion tool 
RUN /miniconda/bin/pip3 install nbconvert \
    && apt-get update && apt-get install -y pandoc \
    && apt-get update && apt-get install -y texlive-xetex texlive-fonts-recommended texlive-generic-recommended \
    && /miniconda/bin/pip3 install pyppeteer
    
 
VOLUME /notebook
WORKDIR /notebook
EXPOSE 8888

CMD /miniconda/bin/jupyter notebook \
                    --port=8888 \
                    --no-browser \
                    --ip=0.0.0.0 \
                    --notebook-dir=/notebook \
                    --NotebookApp.token='' \
                    --allow-root
