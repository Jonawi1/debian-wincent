# Se LICENSE file for copyright and license details.

CC=gcc
CFLAGS=-std=c99 -pedantic -Wall -Wno-deprecated-declarations -Wmissing-declarations -Wmissing-prototypes -Wold-style-definition

SRC = installer.c
OBJ = ${SRC:.c=.o}

all: installer

${OBJ}: config.h

config.h: config.def.h # temporary dependency <------------
	cp config.def.h $@

installer: ${OBJ}
	$(CC) $(CFLAGS) -o $@ ${OBJ}
	
clean:
	rm -f installer ${OBJ}

install: all
	./installer
