# Se LICENSE file for copyright and license details.

CC=gcc
CFLAGS=-g -std=c99 -pedantic -Wall -Wno-deprecated-declarations -Wmissing-declarations -Wmissing-prototypes -Wold-style-definition -pthread

SRC = installer.c safe_memory.c safe_functions.c
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
