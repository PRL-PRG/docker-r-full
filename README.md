# r-full

This is a docker image based on Debian 8 jessie that contains R 3.4 with most of
the available package from CRAN repository. The native library dependencies were
installed using the
[`rcheckserver`])(http://statmath.wu.ac.at/AASC/debian/rcheckserver_2.15-54_amd64.deb)
version 2.15-54.

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
