FROM continuumio/miniconda3
#directory to application, where all files should be copied

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get -y install git gcc g++ && \
    rm -rf /var/lib/apt/lists/*

# copy gcc to g++ as a terrible hack
# RUN cp $(which gcc) $(dirname $(which gcc))/g++ && \
#     echo $(which g++)

#creating conda env
# make sure cmcc-reactions/enviornment.yml in same folder
COPY environment.yml .
RUN conda env create -f environment.yml
RUN conda run -n cmcc-rxn pip install git+https://github.com/isayevlab/AIMNet2

RUN git clone https://github.com/Center-for-Mechanical-Control-of-Chem/cmcc-reactions

ENV PYTHONPATH=cmcc-reactions

#running application
CMD ["conda", "run", "--no-capture-output", "-n", "cmcc-rxn"]
