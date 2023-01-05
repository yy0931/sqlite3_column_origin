AC_INIT([sqlite3_column_origin], [1.0])
AM_INIT_AUTOMAKE([foreign -Wall -Werror])

AC_PROG_CC

# Make sure sqlite3 is installed on the system by checking for the header file and function of sqlite3.
AC_CHECK_HEADERS([sqlite3.h], [], [AC_MSG_ERROR([sqlite3.h not found])])
AC_CHECK_LIB([sqlite3], [sqlite3_open], [], [AC_MSG_ERROR([sqlite3 library not found])])

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
