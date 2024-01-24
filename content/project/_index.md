---
title: "Project"
date: 2022-07-29T11:47:58+02:00
draft: false
---

MEOS (Mobility Engine, Open Source) is a C library for manipulating temporal and spatio-temporal data. It is based on [MobilityDB's](https://mobilitydb.com) data types and functions.

MobilityDB extends [the ISO 19141:2008](https://www.iso.org/standard/41445.html) standard (Geographic information — Schema for moving features) for representing the change of non-spatial attributes of features, which is not covered by the standard. It also takes into account the fact that when collecting mobility data it is necessary to represent “temporal gaps”, that is, for some period of time, no observations were collected, for instance, due to GPS signal loss.

MEOS is heavily inspired by a similar library called [GEOS](https://libgeos.org/) (Geometry Engine, Open Source) — hence the name. A [first version](https://github.com/adonmo/meos) of the MEOS library written in C++ has been proposed by Krishna Chaitanya Bommakanti. However, due to the fact that MEOS codebase is actually a subset of MobilityDB codebase, which is almost entire written in C, this version of the library allows us to evolve both programming environments simultaneously.

MEOS aims to be the base on which more libraries can be built. The following projects are built on top of MEOS: 

* [PyMEOS](https://github.com/MobilityDB/PyMEOS) is a python bindings to MEOS using (CFFI)[https://cffi.readthedocs.io/en/latest/]
* [MobilityDB-python](https://github.com/MobilityDB/MobilityDB-python/) - The python driver for MobilityDB.


