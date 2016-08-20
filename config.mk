# sinit version
VERSION = 1.0

# paths
PREFIX = /
MANPREFIX = $(PREFIX)/share/man

GCC = gcc
#CROSS_COMPILE = arm-linux-gnueabihf-
CC = $(CROSS_COMPILE)$(GCC)
LD = $(CROSS_COMPILE)$(GCC)
CPPFLAGS =
CFLAGS   = -Wextra -Wall -Os
LDFLAGS  = -s -static
