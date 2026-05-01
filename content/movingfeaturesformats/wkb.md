---
title: Well-Known Binary (WKB)
date: 2022-07-29T14:22:51+02:00
draft: false
---

Well-Known Binary (WKB) is the canonical binary encoding for MEOS values. It is the densest representation MEOS supports and the form used for storage, inter-process transfer, and any context where a temporal value travels as bytes — between bindings, into Parquet files, across the network.

## Specification

The byte layout is documented as a versioned specification:

* [**MEOS-WKB Specification (draft v0.9.0)**](https://github.com/MobilityDB/MobilityDB/blob/master/doc/specs/meos-wkb-0.9.md) — the formal byte-format specification, derived by reverse-documentation of the MEOS reference implementation. Tracks every per-family layout (sets, spans, span-sets, temporal Instants / Sequences / SequenceSets, `tbox`, `stbox`), versioning rules, and consumer ecosystem. Companion to RFC [#830](https://github.com/MobilityDB/MobilityDB/issues/830) (TemporalParquet).

The spec was authored from the MEOS reference encoder in [`meos/src/temporal/type_out.c`](https://github.com/MobilityDB/MobilityDB/blob/master/meos/src/temporal/type_out.c) and decoder in [`meos/src/temporal/type_in.c`](https://github.com/MobilityDB/MobilityDB/blob/master/meos/src/temporal/type_in.c). Until ratified as v1.0, the implementation is the authoritative reference; the spec document iterates at v0.9.x.

## Why WKB

WKB extends the [Simple Features WKB](https://libgeos.org/specifications/wkb/) approach used by GEOS and PostGIS to the time dimension. The format is **self-describing** — every value carries its own type tag, flag byte, and any embedded sub-encodings (such as the SRID + endianness for spatial values), so a receiver can reconstruct the original temporal type without out-of-band metadata.

This makes WKB suited to:

- **Storage and database serialization** — what `temporal_as_wkb` / `temporal_from_wkb` produce and consume.
- **Inter-process transfer** — sending values between MobilityDB, MobilityDuck, and any of the bindings without each having to agree on schema metadata.
- **Embedding in container formats** — MEOS-WKB is the byte payload that [TemporalParquet](https://github.com/MobilityDB/MobilityDB/issues/830) wraps with file-level Parquet metadata, mirroring how GeoParquet wraps WKB-encoded geometries.

## Overview of the byte layout

A MEOS-WKB value begins with:

| Byte | Meaning |
|---|---|
| `0x00` or `0x01` | Endian marker (big-endian / little-endian) |
| 2 bytes | Type tag (`T_TGEOMPOINT`, `T_FLOATSPAN`, …) |
| 1 byte | Flag byte (subtype, interpolation, Z, geodetic, SRID-presence, …) |
| (variable) | Type-specific payload — instants array, span endpoints, set elements, etc. |

For spatial-temporal values (`tgeompoint`, `tgeography`, `tgeometry`, `tgeogpoint`), the embedded geometry payload uses unmodified PostGIS Extended WKB (EWKB), allowing existing spatial tools to peek at the spatial component without parsing the temporal envelope.

Boxes (`tbox`, `stbox`) take a slightly different form — they begin with the endian byte directly, skipping the type tag, since the box variant is determined by the flag byte that follows.

## Type coverage

The format covers every MEOS public type:

- Scalar temporals: `tbool`, `tint`, `tfloat`, `ttext`
- Spatial-temporals: `tgeompoint`, `tgeogpoint`, `tgeometry`, `tgeography`
- Sets: `intset`, `floatset`, `bigintset`, `tstzset`, `geomset`, `geogset`, `dateset`, `textset`
- Spans: `intspan`, `floatspan`, `bigintspan`, `tstzspan`, `datespan`
- Span sets: `intspanset`, `floatspanset`, `bigintspanset`, `tstzspanset`, `datespanset`
- Bounding boxes: `tbox`, `stbox`

For per-family byte-layout details, see the [specification](https://github.com/MobilityDB/MobilityDB/blob/master/doc/specs/meos-wkb-0.9.md).

## Use in code

```c
#include <meos.h>

Temporal *t = (Temporal *) tfloat_in("[1.5@2026-01-01, 2.5@2026-01-02]");

size_t size;
uint8_t *wkb = temporal_as_wkb(t, WKB_NDR, &size);  // little-endian
// ... transmit / store wkb ...

Temporal *t2 = (Temporal *) temporal_from_wkb(wkb, size);
```

Equivalent functions exist for every type family (`set_as_wkb`, `span_as_wkb`, `tbox_as_wkb`, etc.). Each binding exposes the same surface in its idiomatic form: `t.as_wkb()` in PyMEOS, `t.asWkb()` in JMEOS, and so on.

The hex variants (`temporal_as_hexwkb`, `temporal_from_hexwkb`) produce / consume the same bytes encoded as ASCII hex — useful for embedding in text protocols (HTTP query strings, JSON columns) where binary safety is fragile.
