FROM prlprg/r-full-base

# CRAN mirrot
ARG REPO="https://cloud.r-project.org"
# packages to install as R string vector
ARG PACKAGES="available.packages()[,1]"
# addtional args for install.packages -- must start with a ','
ARG INSTALL_ARGS=", dependencies=TRUE, destdir='/CRAN', INSTALL_opts=c('--example', '--install-tests', '--with-keep.source', '--no-multiarch'), Ncpus=parallel::detectCores()"

# install packages
# it is important that the Rscript runs via entrypoint.sh which will start Xvfb
RUN mkdir /CRAN && \
    /entrypoint.sh Rscript -e "install.packages($PACKAGES, repos='$REPO' $INSTALL_ARGS)" 2>&1 | tee /install.log
# extract downloaded sources
RUN find -name "/CRAN/*.tar.gz" -exec tar -C /CRAN -xzf {} \; && \
    rm -fr /CRAN/*.tar.gz

LABEL maintainer "krikava@gmail.com"
