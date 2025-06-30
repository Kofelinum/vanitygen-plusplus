## CentOS/Redhat:
# yum install openssl-devel
# yum install libcurl-devel
# yum install check                # Only need if you want to run tests

## Ubuntu:
# apt install build-essential
# apt install libssl-dev
# apt install libpcre3-dev
# apt install libcurl4-openssl-dev
# apt install check                # Only need if you want to run tests

## MacOS:
# brew install openssl@3
# brew install pcre

LIBS=-lpcre -lcrypto -lm -lpthread
CFLAGS=-ggdb -O3 -Wall -Wno-deprecated
# CFLAGS=-ggdb -Wall -Wno-deprecated -fsanitize=address
# CFLAGS=-ggdb -O3 -Wall -I /usr/local/cuda-10.2/include/

OBJS=vanitygen.o oclvanitygen.o oclvanityminer.o oclengine.o keyconv.o pattern.o util.o sha3.o
PROGS=vanitygen++ keyconv oclvanitygen++ oclvanityminer

PLATFORM=$(shell uname -s)
ifeq ($(PLATFORM),Darwin)
	OPENCL_LIBS=-framework OpenCL
	LIBS+=-L/opt/homebrew/opt/openssl/lib
	CFLAGS+=-I/opt/homebrew/opt/openssl/include
	LIBS+=-L/opt/homebrew/opt/pcre/lib
	CFLAGS+=-I/opt/homebrew/opt/pcre/include
else ifeq ($(PLATFORM),NetBSD)
	LIBS+=`pcre-config --libs`
	CFLAGS+=`pcre-config --cflags`
else
	OPENCL_LIBS=-lOpenCL
endif


most: vanitygen++ keyconv

all: $(PROGS)

vanitygen++: vanitygen.o pattern.o util.o sha3.o
	$(CC) $^ -o $@ $(CFLAGS) $(LIBS)

oclvanitygen++: oclvanitygen.o oclengine.o pattern.o util.o sha3.o
	$(CC) $^ -o $@ $(CFLAGS) $(LIBS) $(OPENCL_LIBS)

oclvanityminer: oclvanityminer.o oclengine.o pattern.o util.o sha3.o
	$(CC) $^ -o $@ $(CFLAGS) $(LIBS) $(OPENCL_LIBS) -lcurl

keyconv: keyconv.o util.o sha3.o
	$(CC) $^ -o $@ $(CFLAGS) $(LIBS)

TESTS=tests/test_trx

$(TESTS): tests/test_trx.c util.o sha3.o
	$(CC) tests/test_trx.c util.o sha3.o -I. $(CFLAGS) -lcrypto -lm -lpthread -o $@

test: $(TESTS)
	./$<

clean:
	rm -f $(OBJS) $(PROGS) $(TESTS) *.oclbin
