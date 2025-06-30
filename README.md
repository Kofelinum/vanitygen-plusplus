# Vanitygen++ for TRON

This project provides a simple tool to generate vanity addresses for the TRON (TRX) blockchain.

## Example
```bash
$ ./vanitygen++ -C TRX TRX123
```

The output will display a TRX address beginning with `TRX123` and the corresponding private key.

## Build
Run `make` to build the command line tools. If you have an OpenCL capable GPU you can build the GPU versions as well:
```bash
$ make oclvanitygen++ oclvanityminer
```
