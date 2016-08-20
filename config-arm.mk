# sinit version
VERSION = 1.0

# paths
PREFIX = /
MANPREFIX = $(PREFIX)/share/man

CC = gcc
CROSS_COMPILE = arm-linux-gnueabihf-
LD = $(CROSS_COMPILE)$(CC)
CPPFLAGS =
CFLAGS   = -Wextra -Wall -Os
LDFLAGS  = -s -static
