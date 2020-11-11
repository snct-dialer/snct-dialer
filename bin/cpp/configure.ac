#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([FULL-PACKAGE-NAME], [VERSION], [BUG-REPORT-ADDRESS])
AC_CONFIG_SRCDIR([src/GenRealTimeData.cpp])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES(Makefile src/Makefile)
AM_INIT_AUTOMAKE([foreign dist-xz subdir-objects])


# Checks for programs.
AC_PROG_CXX


# Checks for libraries.
AC_SEARCH_LIBS(mysql_init,[mysqlclient mariadbclient],,AC_MSG_ERROR(zm requires libmysqlclient.a or libmariadbclient.a))

# Checks for header files.
AC_CHECK_HEADER(mariadb/mysql.h)
AC_CHECK_HEADERS([syslog.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_CHECK_HEADER_STDBOOL
AC_FUNC_MKTIME

# Checks for library functions.

AC_OUTPUT
