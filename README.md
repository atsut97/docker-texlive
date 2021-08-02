# docker-texlive

Docker image to run typesetting of TeX documents for my personal
usage.

## About this repository

This is the Git repository of the Docker image to run typesetting of
TeX documents for my personal usage. The features of this Docker image
are as follows:
  * Installs the latest TeX Live including Japanese environment.
  * Installs my preferred tools such as:
    * Inkscape
    * Ghostscript
    * Git
    * GNU Make
    * etc.

## Usage

Let's say you have a file `main.tex` in the current working directory.
The built image is hosted on
[dockerhub](https://hub.docker.com/repository/docker/atsut97/texlive),
so you can pull it and run typesetting as the following:

``` shell
docker run --rm -it --volume $PWD:/work atsut97/texlive:latest latexmk main.tex
```

## License

The build script `Dockerfile` itself and other helper scripts are
licensed under the MIT License.
