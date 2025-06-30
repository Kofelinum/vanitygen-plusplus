# Vanitygen++ for TRON

This project provides a simple tool to generate vanity addresses for the TRON (TRX) blockchain.

## Example
```bash
$ ./vanitygen++ -C TRX TRX123
```

The output will display a TRX address beginning with `TRX123` and the corresponding private key.

## Options
Vanitygen++ accepts a variety of flags for customizing the search. Some useful ones are:

- `-i` – perform a **case-insensitive** search.
- `-B` – match a pattern **anywhere** in the address, not just the prefix.
- `-A` – match the pattern **at the end** of the address (suffix match).
- Without `-B` or `-A`, patterns are matched against the **prefix** by default.
- `-r` – interpret patterns as regular expressions.
- `-k` – keep searching after finding a match instead of stopping.
- `-1` – stop after the **first** successful match.
- `-a <num>` – generate exactly `<num>` address/key pairs and then stop.

Run `./vanitygen++ -h` to see the full list of available options.

## Build
Run `make` to build the command line tools. If you have an OpenCL capable GPU you can build the GPU versions as well:
```bash
$ make oclvanitygen++ oclvanityminer
```

### Dependencies
Install the OpenSSL and PCRE development packages for your system before
building. The optional OpenCL headers and libraries are only required for
the GPU versions (`oclvanitygen++` and `oclvanityminer`).
