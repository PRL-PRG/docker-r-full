FROM prlprg/r-full-base

# run the package installation
ARG CRAN_CONTRIB_URL="https://cloud.r-project.org/src/contrib"
ARG IGNORED_PACKAGES=""

ADD install-cran-packages.R /
RUN chmod +x /install-cran-packages.R

ENV CRAN_CONTRIB_URL=${CRAN_CONTRIB_URL}
ENV IGNORE_PACKAGES=${IGNORED_PACKAGES}
RUN /install-cran-packages.R

LABEL maintainer "krikava@gmail.com"

CMD ["R"]
