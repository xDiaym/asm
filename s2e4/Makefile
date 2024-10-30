CC?=gcc
CFLAGS=-lusb-1.0

.PHONY: all
all: build

.PHONY: build
build:
	$(CC) $(CFLAGS) main.c -o s2e4

.PHONY: clean
clean:
	rm s2e4
