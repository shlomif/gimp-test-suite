dnl Process this file with autoconf to produce a configure script.
AC_INIT(seedserve.c)

AM_INIT_AUTOMAKE(libseedserve, 0.1.3)

AM_PROG_LIBTOOL

dnl Checks for programs.
AC_PROG_CC

dnl Checks for header files.
AC_HEADER_STDC
AC_CHECK_HEADERS(sys/time.h unistd.h)

debug_rwlock=no

dnl Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST
AC_HEADER_TIME

AM_PATH_GLIB_2_0(2.0.0)

AC_OUTPUT([Makefile])
