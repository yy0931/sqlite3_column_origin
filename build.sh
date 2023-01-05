#!/bin/sh

set -e

run_as_root() {
  if [ "$(id -u)" -eq 0 ]; then  # Check if the user is root
    # shellcheck disable=SC2068
    $@
  else
    # shellcheck disable=SC2068
    sudo $@
  fi
}

if command -v apt > /dev/null; then
    # Debian/Ubuntu
    # Installing automake and libtool wasn't necessary in my environment and docker containers, but some environments may need them: https://github.com/buffer/pylibemu/issues/24
    run_as_root apt update
    run_as_root apt install -y automake autoconf libtool gcc make libsqlite3-dev
elif command -v dnf > /dev/null; then
    # Fedora
    run_as_root dnf install -y automake autoconf libtool gcc make libsqlite3x-devel
elif command -v yum > /dev/null; then
    # RedHat/CentOS
    run_as_root yum install -y automake autoconf libtool gcc make libsqlite3x-devel
elif command -v zypper > /dev/null; then
    # openSUSE
    run_as_root zypper install -y automake autoconf libtool gcc make sqlite3-devel
elif command -v pacman > /dev/null; then
    # Arch
    run_as_root pacman -Sy
    run_as_root pacman -S --noconfirm automake autoconf libtool gcc make sqlite
elif command -v apk > /dev/null; then
    # Alpine Linux
    # g++ is added to fix "checking for gcc... gcc\nchecking whether the C compiler works... no"
    run_as_root apk update
    run_as_root apk add automake autoconf libtool gcc make sqlite-dev g++
elif command -v pkg > /dev/null; then
    # MacOS
    # TODO: Not tested with a fresh install. sqlite3 and pkg-config may not be needed.
    brew update
    brew install automake autoconf libtool gcc make sqlite3 pkg-config
else
    echo "Error: Could not find a supported package manager. Please install automake autoconf libtool gcc make libsqlite3-dev manually."
    exit 1
fi

autoreconf --install
./configure
make
