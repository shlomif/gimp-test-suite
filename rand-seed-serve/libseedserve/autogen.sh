#!/bin/sh

aclocal
automake --add-missing
libtoolize
autoconf

