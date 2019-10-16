
# find the OS
uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')

# Compile flags for linux / osx
ifeq ($(uname_S),Linux)
	SHOBJ_CFLAGS ?=  -fno-common -g -ggdb
	SHOBJ_LDFLAGS ?= -shared -Bsymbolic
else
	SHOBJ_CFLAGS ?= -dynamic -fno-common -g -ggdb
	SHOBJ_LDFLAGS ?= -bundle -undefined dynamic_lookup
endif

CFLAGS = -Wall -g -fPIC -std=gnu99
CC=gcc

all: timer.so

timer.so: timer.o
	$(LD) -o $@ timer.o $(SHOBJ_LDFLAGS) $(LIBS) -lc -lm

timer.o: timer.c
	$(CC) -c -o timer.o $(SHOBJ_CFLAGS) $(CFLAGS) timer.c

clean:
	rm -rf *.xo *.so *.o

FORCE:
