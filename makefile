#!/usr/bin/make
## makefile (for s7)
## Mac Radigan

# This is a fork of the Stanford CCRMA s7 Scheme
#
# The distribution you are most likely looking for may be found at:
#   https://ccrma.stanford.edu/software/snd/

# According to Bill Schottstaedt's verbiage in s7.c, s7 is a fork of TinyScheme, and 
#   has a BSD license:
#
# """ 
#   * --------------------------------------------------------------------------------
#   * T I N Y S C H E M E    1 . 3 9
#   *   Dimitrios Souflis (dsouflis@acm.org)
#   *   Based on MiniScheme (original credits follow)
#   * (MINISCM)               coded by Atsushi Moriwaki (11/5/1989)
#   * (MINISCM)           E-MAIL :  moriwaki@kurims.kurims.kyoto-u.ac.jp
#   * (MINISCM) This version has been modified by R.C. Secrist.
#   * (MINISCM)
#   * (MINISCM) Mini-Scheme is now maintained by Akira KIDA.
#   * (MINISCM)
#   * (MINISCM) This is a revised and modified version by Akira KIDA.
#   * (MINISCM)	current version is 0.85k4 (15 May 1994)
#   * --------------------------------------------------------------------------------
#   *
#   * apparently tinyScheme is under the BSD license, so I guess s7 is too.
#   * Here is Snd's verbiage which can apply here:
#   *
#   *     The authors hereby grant permission to use, copy, modify, distribute,
#   *     and license this software and its documentation for any purpose.  No
#   *     written agreement, license, or royalty fee is required.  Modifications
#   *     to this software may be copyrighted by their authors and need not
#   *     follow the licensing terms described here.
#   *
#   * followed by the usual all-caps shouting about liability.
#   *
#   * --------------------------------------------------------------------------------
#   *
#   * s7, Bill Schottstaedt, Aug-08, bil@ccrma.stanford.edu
#   *
#   * Mike Scholz provided the FreeBSD support (complex trig funcs, etc)
#   * Rick Taube, Andrew Burnson, Donny Ward, and Greg Santucci provided the MS Visual C++ support
#   *
#   * Documentation is in s7.h and s7.html.
# """

LIBS_O = s7.o ffitest.o libc_s7.o
LIBS_SO = $(LIBS_O:.o=.so)
ARCH = -m64
CFLAGS = -fPIC -O2 $(ARCH) -g3
LDFLAGS = -O2 $(ARCH) -g -L/usr/local/lib/libtecla.a -lm -ldl -ltecla -lcurses 

all: build

build: $(LIBS_SO) libs7.a
	$(CC) s7-repl.c -o s7 s7.o -I. $(LDFLAGS)

%.so: %.o
	$(CC) -shared -o lib$@ $<

libs7.a: $(LIBS_O)
	ar rvs $@ $^

clean:
	-rm -f ./*.o

clobber: clean
	-rm -f ./s7
	-rm -f ./*.so

## *EOF*
