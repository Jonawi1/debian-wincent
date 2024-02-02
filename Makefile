CC=gcc
CFLAGS=-g -Werror -Wall -Wextra -Wpedantic -Wmissing-declarations -Wmissing-prototypes -Wold-style-definition

installer: installer.c
	$(CC) $(CFLAGS) -o $@ $^
	
clean:
	rm -f installer
