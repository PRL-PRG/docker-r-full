# r-full

This is a docker image based on [docker-r-full-base](https://github.com/PRL-PRG/docker-r-full-base) 
containing almost all CRAN packages (all but the ones withe dependencies on tcltk2).

## Usage

```sh
$ docker run -ti --rm prlprg/r-full

R version 3.4.0 (2017-04-21) -- "You Stupid Darkness"
Copyright (C) 2017 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

> nrow(installed.packages())
[1] 10345
```

## Buidling

```sh
$ cd docker-r-full
$ docker build --rm --build-arg CRAN_CONTRIB_URL="http://mirrors.nic.cz/R/src/contrib" --build-arg IGNORED_PACKAGES="tcltk2" -t prl-prg/r-full .
```

There are two build arguments:
- `CRAN_CONTRIB_URL`: the URL to the source contrib CRAN repository, default is [`https://cloud.r-project.org/src/contrib`](https://cloud.r-project.org/src/contrib).
- `IGNORED_PACKAGES`: the list of comma-separated packages that should be ignored.

The process can be followed in another terminal using the following:

```sh
docker logs -f <build-container-id> 2>&1 | grep "^INSTALL"
INSTALL: Ignored packages: tcltk2
INSTALL: # of available packages to install: 10921
INSTALL: # of transitively ignored packages: 73
INSTALL: # of packages selected to install: 10848
INSTALL: # of already installed packages: 29
INSTALL: # of packages to be installed: 10833
INSTALL: A3 - installing (1/10833)
INSTALL: abbyyR - installing (2/10833)
... ... ...
... ... ...
... ... ...
```
