---
title: "Installation"
date: 2024-08-12T15:54:38+02:00
draft: false
---

Requirements
------------

*   Linux (other UNIX-like systems may work, but remain untested)
*   CMake >= 3.7
*   GEOS >= 3.8
*   PROJ4 >= 6.1
*   JSON-C
*   GNU Scientific Library (GSL)
*   Development files for GEOS, PROJ4, JSON-C, and GSL

For example, you can use the following command to install all MEOS build dependencies for Debian-based systems:
```bash
apt install build-essential cmake libgeos-dev libproj-dev libjson-c-dev libgsl-dev
```

Building & Installation
-----------------------

MEOS is installed in a similar was as MobilityDB as stated
[here](https://github.com/MobilityDB/MobilityDB) by setting the flag 
`-DMEOS=1`

Here is the gist:
```bash
git clone https://github.com/MobilityDB/MobilityDB
mkdir MobilityDB/build
cd MobilityDB/build
cmake `-DMEOS=1` ..
make
sudo make install
```




