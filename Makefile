CC=gcc
CFLAGS=-g -Werror -Wall -Wmissing-declarations -Wmissing-prototypes -Wold-style-definition

installer: installer.c
	$(CC) $(CFLAGS) -o $@ $^
	
clean:
	rm -f installer
