FROM prlprg/r-full-base

# run the package installation
ARG REPO="https://cloud.r-project.org"
ARG PACKAGES="available.packages()[,1]"
ARG INSTALL_ARSG=", destdir=/CRAN, INSTALL_opts=c('--example', '--install-tests', '--with-keep.source', '--no-multiarch')"

RUN Rscript -e "install.packages($PACKAGES, repos='$REPO' $INSTALL_ARGS)" > /install.log 2>&1

LABEL maintainer "krikava@gmail.com"

CMD ["R"]
