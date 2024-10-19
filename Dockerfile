FROM continuumio/miniconda3
#directory to application, where all files should be copied

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get -y install git gcc g++ && \
    rm -rf /var/lib/apt/lists/*

#creating conda env
# make sure cmcc-reactions/enviornment.yml in same folder
COPY environment.yml .
RUN conda env create -f environment.yml
RUN conda run -n cmcc-rxn pip install git+https://github.com/isayevlab/AIMNet2

# install default version of the package
RUN cd /home && \
    git clone https://github.com/Center-for-Mechanical-Control-of-Chem/cmcc-reactions
ENV PYTHONPATH=/home/cmcc-reactions

# configure AIMNet2 to work in default mode
RUN conda run -n cmcc-rxn python -c "import aimnet2calc; calc = aimnet2calc.AIMNet2ASE()"

# configure commands to run in the specified env by default
ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "cmcc-rxn"]
