# r-full-cran

This is a docker image based on [docker-r-full-base](https://github.com/PRL-PRG/docker-r-full-base) 
containing almost all CRAN packages (all but the ones withe dependencies on tcltk2).

## Usage

```sh
R version 3.5.0 (2018-04-23) -- "Joy in Playing"
Copyright (C) 2018 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

> nrow(installed.packages())
[1] 9452
> nrow(available.packages())
[1] 12519
```

## Buidling

```sh
$ cd docker-r-full-cran
$ docker build --rm --build-arg REPO="http://mirrors.nic.cz/R/src/contrib" -t prlprg/r-full-cran .
```

There are the following build arguments:
- `REPO`: the mirror to use to fetch the packages. Defaults to `"https://cloud.r-project.org"`. To find a mirror do `chooseCRANmirror(); getOption("repos")` in some R session.
- `PACKAGES`: which packages to install in a form of R string vector. Defaults to `"available.packages()[,1]"`
- `INSTALL_ARSG`: additional arguments to `install.packages` - must start with `,` as they will be blindly appended. Defaults to `", destdir=/CRAN, INSTALL_opts=c('--example', '--install-tests', '--with-keep.source', '--no-multiarch')"`

The result of the installation is in `/install.log` in the image.
