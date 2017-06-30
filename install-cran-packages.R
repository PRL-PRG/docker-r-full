#!/usr/bin/env Rscript

contrib_url <- Sys.getenv("CRAN_CONTRIB_URL")
if (contrib_url == "") {
    stop("CRAN_CONTRIB_URL is missing")
}

ignored <- Sys.getenv("IGNORED_PACKAGES")
if (nchar(ignored) > 0) {
    ignored <- strsplit(ignored, ",")[[1]]
}
message("INSTALL: Ignored packages: ", paste(ignored, collapse=", "))

available <- available.packages(contrib_url)
packages <- available[, 1]
message("INSTALL: # of available packages to install: ", length(packages))

ignored_all <- tools::dependsOnPkgs(ignored, recursive=T, installed=available)
message("INSTALL: # of transitively ignored packages: ", length(ignored_all))

packages <- setdiff(packages, ignored_all)
message("INSTALL: # of packages selected to install: ", length(packages))

installed <- installed.packages()[, 1]
message("INSTALL: # of already installed packages: ", length(installed))

packages <- setdiff(packages, installed)
message("INSTALL: # of packages to be installed: ", length(packages))

curr <- 0
N <- length(packages)
lib_dir <- .libPaths()[1]

for (pkg in packages) {
    curr <- curr + 1

    if (dir.exists(file.path(lib_dir, pkg))) {
        message("INSTALL: ", pkg, " - already installed (", curr, "/", N, ")")
    } else {
        message("INSTALL: ", pkg, " - installing (", curr, "/", N, ")")
        install.packages(
            pkg,
            contriburl=contrib_url,
            type='source',
            dependencies=TRUE,
            INSTALL_opts=c('--example', '--install-tests', '--with-keep.source', '--no-multiarch'))
    }
}

message("INSTALL: # of installed packages: ", nrow(installed.packages()))
