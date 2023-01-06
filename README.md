You need a C compiler and libsqlite3 to build the program. If you don't have them, you can use the following commands to install them:

- Debian/Ubuntu: `sudo apt update && sudo apt install -y gcc libsqlite3-dev`
- Fedora: `sudo dnf install -y gcc libsqlite3x-devel`
- RedHat/CentOS: `sudo yum install -y gcc libsqlite3x-devel`
- openSUSE: `sudo zypper install -y gcc sqlite3-devel`
- Arch: `sudo pacman -Sy && sudo pacman -S --noconfirm gcc sqlite`
- Alpine: `sudo apk update && sudo apk add gcc g++ sqlite-dev`
- MacOS: `brew install gcc sqlite3` (sqlite3 might not be needed.)
- Windows: Please [submit a pull request](https://github.com/yy0931/sqlite3_column_origin/pulls) to add support for it!

Once you have the requirements, build the program with the following command. You can replace `gcc` with other compilers.

```shell
gcc sqlite3_column_origin.c -Wall -Werror -lsqlite3 -o sqlite3_column_origin
```

You can test the program by running the following command. It should print the string "PASS".
```shell
./test.sh
```
