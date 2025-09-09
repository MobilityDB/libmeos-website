---
title: "MEOS"
date: 2022-07-28T12:25:21Z
draft: false
---

MEOS (Mobility Engine, Open Source) is a C library and its associated API for manipulating temporal and spatiotemporal data. It is the core component of [MobilityDB](https://mobilitydb.com), an open source geospatial trajectory data management & analysis platform built on top of [PostgreSQL](https://www.postgresql.org/) and [PostGIS](https://postgis.net/).

MEOS extends the [ISO 19141:2008](https://www.iso.org/standard/41445.html) standard (Geographic information — Schema for moving features) for representing the change of non-spatial attributes of features. It also takes into account the fact that when collecting mobility data it is necessary to represent “temporal gaps”, that is, when for some period of time no observations were collected due, for instance, to signal loss.

MEOS is inspired by a similar library called [GEOS](https://libgeos.org/) (Geometry Engine, Open Source) — hence the name. A [first version](https://github.com/adonmo/meos) of the MEOS library written in C++ has been proposed by Krishna Chaitanya Bommakanti. However, due to the fact that MEOS codebase is actually a subset of MobilityDB codebase, which is written in C and in SQL, the current version of the library allows us to evolve both [programming environments](https://github.com/MobilityDB/MobilityDB/wiki/Building-MobilityDB-and-MEOS) simultaneously.

MEOS aims to be the base library on which other projects can be built. For example, the following projects are built on top of MEOS:

* [MobilityDB](https://mobilitydb.com) is a PostgreSQL extension that enables storing and manipulating the data types provided by MEOS.
* [PyMEOS](https://github.com/MobilityDB/PyMEOS) is a Python binding to MEOS using [CFFI](https://cffi.readthedocs.io/en/latest/)
* [JMEOS](https://github.com/MobilityDB/JMEOS) is a Java binding to MEOS using [JNR-FFI](https://github.com/jnr/jnr-ffi)
* [meos.rs](https://github.com/MobilityDB/meos-rs) is a Rust binding for MEOS.
* [GoMEOS](https://github.com/MobilityDB/GoMEOS) is a Go driver for MEOS.
* [MEOS.net](https://github.com/MobilityDB/MEOS.net) is a C# binding for MEOS.


Other projects can built on top of MEOS, for example, MEOS bindings for other programming languages or implementing MEOS on other DBMSs such as MySQL or platforms such as Spark or Flink.


Ackowledgements
---------------

<img src="/images/eu-flag.jpg" alt="EU Flag" style="width: 100px; float:left; margin-right: 10px;" align="middle" />
<p>
The MobilityDB project has received funding from the European Union's <a href="https://open-research-europe.ec.europa.eu/gateways/horizon-europe">Horizon Europe</a> research and innovation programme under grant agreements No 101070279 <a href="https://mobispaces.eu/" target="blank">MobiSpaces</a> and No 101093051 <a href="https://emeralds-horizon.eu/" target="blank">EMERALDS</a>.
</p>
