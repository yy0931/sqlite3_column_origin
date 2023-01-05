#!/bin/bash
clean() {
    rm -rf .deps autom4te.cache compile configure 'configure~' depcomp install-sh Makefile missing sqlite3_column_origin Makefile.in config.log aclocal.m4 sqlite3_column_origin.o config.status
}

clean
podman run -it --rm -v "$PWD:$PWD" -w "$PWD" docker.io/ubuntu:16.04 ./build.sh

clean
podman run -it --rm -v "$PWD:$PWD" -w "$PWD" docker.io/ubuntu:22.04 ./build.sh

clean
podman run -it --rm -v "$PWD:$PWD" -w "$PWD" docker.io/fedora ./build.sh

clean
podman run -it --rm -v "$PWD:$PWD" -w "$PWD" docker.io/archlinux ./build.sh

clean
podman run -it --rm -v "$PWD:$PWD" -w "$PWD" docker.io/opensuse/leap ./build.sh

clean
podman run -it --rm -v "$PWD:$PWD" -w "$PWD" docker.io/alpine ./build.sh
