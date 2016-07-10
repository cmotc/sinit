# sinit version
VERSION = 1.0

# paths
PREFIX = /usr/
MANPREFIX = $(PREFIX)/share/man

#CC = cc
CC = arm-linux-gnueabihf-gcc
LD = $(CC)
CPPFLAGS =
CFLAGS   = -Wextra -Wall -Os
LDFLAGS  = -s -static
