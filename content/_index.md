---
title: "MEOS"
date: 2022-07-28T12:25:21Z
draft: false
---

MEOS (Mobility Engine, Open Source) is a C library for temporal and spatiotemporal data — moving objects, time-varying values, and time spans / sets. Databases, query engines, and language bindings consume MEOS to expose temporal types in their respective environments.

MEOS extends the [ISO 19141:2008](https://www.iso.org/standard/41445.html) standard (Geographic information — Schema for moving features) to also represent the change of non-spatial attributes of features and the *temporal gaps* inherent to mobility data — periods during which no observations were collected, for instance due to signal loss.

The library is inspired by [GEOS](https://libgeos.org/) (Geometry Engine, Open Source) — hence the name.

## Where MEOS is consumed

MEOS exposes its type system through bindings tailored to each host environment.

| Environment | Binding |
|---|---|
| PostgreSQL | [MobilityDB](https://mobilitydb.com) |
| DuckDB | [MobilityDuck](https://github.com/MobilityDB/MobilityDuck) |
| Python | [PyMEOS](https://github.com/MobilityDB/PyMEOS) |
| Java | [JMEOS](https://github.com/MobilityDB/JMEOS) |
| Rust | [meos-rs](https://github.com/MobilityDB/meos-rs) |
| Go | [GoMEOS](https://github.com/MobilityDB/GoMEOS) |
| .NET | [MEOS.NET](https://github.com/MobilityDB/MEOS.NET) |
| JavaScript | [MEOS.js](https://github.com/MobilityDB/MEOS.js) |

Each binding exposes the same MEOS type system using the conventions of its host environment: SQL functions in PostgreSQL/DuckDB, idiomatic classes in PyMEOS / JMEOS / meos-rs / GoMEOS / MEOS.NET / MEOS.js. The C library is the source of truth for type semantics, encoding, and behaviour.

## Architecture

```mermaid
flowchart TB
  meos(["MEOS<br/>C library"])
  pg["MobilityDB<br/>(PostgreSQL)"]
  duck["MobilityDuck<br/>(DuckDB)"]
  py["PyMEOS<br/>(Python)"]
  java["JMEOS<br/>(Java)"]
  rust["meos-rs<br/>(Rust)"]
  go["GoMEOS<br/>(Go)"]
  net["MEOS.NET<br/>(.NET / C#)"]
  js["MEOS.js<br/>(JavaScript)"]

  pg --> meos
  duck --> meos
  py --> meos
  java --> meos
  rust --> meos
  go --> meos
  net --> meos
  js --> meos
```

Other consumers can be built directly on top of MEOS — additional language bindings, integrations with other DBMSs, or analytics platforms (Spark, Flink, Apache Beam, etc.). The MEOS C API is the common substrate.

## Learn the basics

A nine-step tutorial series walks through the essence of the library:

1. [Hello World](/tutorialprograms/01_hello_world/) — first temporal point values and MF-JSON output.
2. [AIS Read](/tutorialprograms/02_ais_read/) — parsing AIS observation records into temporal values.
3. [AIS Assemble](/tutorialprograms/03_ais_assemble/) — building trajectories from streaming observations.
4. [AIS Store](/tutorialprograms/04_ais_store/) / [AIS Stream](/tutorialprograms/04_ais_stream_db/) — persisting trajectories to MobilityDB.
5. [BerlinMOD Disassemble](/tutorialprograms/05_berlinmod_disassemble/) — splitting trips into instants.
6. [BerlinMOD Clip](/tutorialprograms/06_berlinmod_clip/) — restricting trajectories to spatial regions.
7. [BerlinMOD Tile](/tutorialprograms/07_berlinmod_tile/) — spatiotemporal tiling.
8. [BerlinMOD Simplify](/tutorialprograms/08_berlinmod_simplify/) — line-simplification of trajectories.
9. [BerlinMOD Aggregate](/tutorialprograms/09_berlinmod_aggregate/) — temporal aggregation.

The numbered series is intentionally simplified — small datasets, well-formed input, no error handling — so that the MEOS API is the focus of attention rather than the I/O scaffolding around it. For each step there's a real-world counterpart in [`meos/examples/`](https://github.com/MobilityDB/MobilityDB/tree/master/meos/examples) named `*_full.c` (for instance, `ais_assemble_full.c` is the production-grade companion to `03_ais_assemble.c`): realistic file sizes, malformed inputs, edge cases, and error recovery. Use the numbered example to learn the API; use the `_full` counterpart as a reference when wiring MEOS into production code.

Beyond the tutorial ladder, [`meos/examples/`](https://github.com/MobilityDB/MobilityDB/tree/master/meos/examples) also contains feature-specific examples: rtree indexing, k-means / DBSCAN clustering, projection, transforms, expansion, network points, and more.

## Encodings

MEOS defines stable on-the-wire encodings for temporal values, allowing data to round-trip between bindings without loss:

* [Well-Known Text (WKT)](/movingfeaturesformats/wkt/) — human-readable.
* [Well-Known Binary (WKB)](/movingfeaturesformats/wkb/) — compact binary, the canonical interchange format.
* [Moving-Features JSON (MF-JSON)](/movingfeaturesformats/mfjson/) — OGC-aligned JSON.

A trajectory written from one binding can be read by any other.

## Origin

A [first version](https://github.com/adonmo/meos) of MEOS, written in C++, was contributed by Krishna Chaitanya Bommakanti. The current C library evolved from that origin and has been the canonical implementation since.

## Acknowledgements

<img src="/images/eu-flag.jpg" alt="EU Flag" style="width: 100px; float:left; margin-right: 10px;" align="middle" />
<p>
The MobilityDB project has received funding from the European Union's <a href="https://open-research-europe.ec.europa.eu/gateways/horizon-europe">Horizon Europe</a> research and innovation programme under grant agreements No 101070279 <a href="https://mobispaces.eu/" target="blank">MobiSpaces</a> and No 101093051 <a href="https://emeralds-horizon.eu/" target="blank">EMERALDS</a>.
</p>
