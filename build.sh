#!/bin/sh

docker build --rm --build-arg REPO='http://mirrors.nic.cz/R' -t prlprg/r-full-cran .
