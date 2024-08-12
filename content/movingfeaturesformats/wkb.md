---
title: Well-Known Binary (WKB)
date: 2022-07-29T14:22:51+02:00
draft: true
---

“Well-known binary” is a scheme for writing moving features into a platform-independent array of bytes, usually for transport between systems or between programs. By using WKB, systems can avoid exposing their particular internal implementation of moving feature storage, for greater overall interoperability. It is an extension of the scheme for writing a [simple features](https://en.wikipedia.org/wiki/Simple_Features) geometry into a [platform-independent array of bytes](https://libgeos.org/specifications/wkb/).

### Data Types

The WKB specification uses five basic types common to most typed languages: an unsigned byte, a 4-byte unsigned integer, an 8-byte unsigned integer, an [8-byte IEEE double](https://en.wikipedia.org/wiki/Double-precision_floating-point_format), and a string of characters.

```
// byte : 1 byte
// uint32 : 32 bit unsigned integer (4 bytes)
// uint64 : 64 bit unsigned integer (8 bytes)
// double : double precision number (8 bytes)
// string : string of characters (variable number of bytes)
```

### Byte Order

In order to allow portability between systems with difference architectures, the representation of those types is conditioned by the `wkbByteOrder`.

```
enum wkbByteOrder  {
wkbXDR = 0, // Big Endian
wkbNDR = 1  // Little Endian
};
```

A “little endian” integer has the least-significant bytes first, hence “little”. For example, the number 1, encoded in little- and big- endian:

```
# Little endian
01 00 00 00

# Big endian
00 00 00 01
```

In practice this means that almost all WKB is encoded little endian, since most modern processors are little endian, but the existence of the wkbByteOrder allows WKB to transport geometry easily between systems of different endianness.


