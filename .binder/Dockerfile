FROM rocker/binder:4.0.2
LABEL maintainer='Ani Ruhil'
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}

RUN wget https://github.com/aniruhil/tutoRials/raw/main/DESCRIPTION && R -e "options(repos = list(CRAN = 'http://mran.revolutionanalytics.com/snapshot/2021-07-09/')); devtools::install_deps()"

# Install R devtools
RUN R -q -e 'install.packages("devtools", repos="http://cran.r-project.org")'

# Install IRPython
COPY install-irkernel.r /tmp/
RUN cd /tmp \
 && git clone https://github.com/rgbkrk/rzmq.git --recursive \
 && cd rzmq/src \
 && echo "CXX_STD = CXX11\nPKG_CPPFLAGS = -std=c++11 -I../inst/cppzmq\nPKG_LIBS = -lzmq" > Makevars \
 && cd /tmp && Rscript install-irkernel.r \
 && rm -rf /tmp/*


# Jupyter config
RUN jupyter notebook --generate-config \
 && echo "\nimport os\nfrom IPython.lib import passwd\npassword = os.environ.get('JUPYTER_PASSWORD')\nif password:\n  c.NotebookApp.password = passwd(password)\n" \
    >> ~/.jupyter/jupyter_notebook_config.py \
 && echo '\nos.environ["R_PLASMA_NUM_THREADS"] = "1"\n' \
    >> ~/.jupyter/jupyter_notebook_config.py
COPY notebook.json /root/.jupyter/nbconfig/

# Expose Jupyter port
EXPOSE 8888

RUN rm DESCRIPTION.1; exit 0
