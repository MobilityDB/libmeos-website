---
title: "Type Catalog"
date: 2026-05-01T00:00:00Z
draft: false
---

A reference list of every type MEOS exposes. For the conceptual model
behind temporal types (instant / sequence / sequence-set subtypes,
discrete / linear / stepwise interpolation, bounding boxes), see the
[Data Model](../datamodel/) page.

## Temporal types

Temporal types represent the evolution of a value over time. Each is
parameterised by a *base type* and is available in the three subtypes
(`Instant`, `Sequence`, `Sequence Set`) described in the data model.

| Type | Base type | Notes |
|---|---|---|
| `tbool` | `bool` | discrete or stepwise interpolation only |
| `tint` | `int` | discrete or stepwise interpolation only |
| `tfloat` | `float` | discrete, linear, or stepwise interpolation |
| `ttext` | `text` | discrete or stepwise interpolation only |
| `tgeompoint` | 2D / 3D `geometry` point | spatial-temporal in a Cartesian plane (any SRID) |
| `tgeogpoint` | 2D / 3D `geography` point | spatial-temporal on the geodetic sphere |
| `tgeometry` | arbitrary `geometry` | beyond points: lines, polygons, collections |
| `tgeography` | arbitrary `geography` | geodetic counterpart of `tgeometry` |

## Span types

Spans represent contiguous ranges over an ordered base type. They
correspond to PostgreSQL [range types](https://www.postgresql.org/docs/current/rangetypes.html).

| Type | Range over |
|---|---|
| `intspan` | `int` |
| `bigintspan` | `bigint` |
| `floatspan` | `float` |
| `datespan` | `date` |
| `tstzspan` | `timestamp with time zone` |

## Span set types

A span set is a finite union of spans of the same family.

| Type | Underlying span |
|---|---|
| `intspanset` | `intspan` |
| `bigintspanset` | `bigintspan` |
| `floatspanset` | `floatspan` |
| `datespanset` | `datespan` |
| `tstzspanset` | `tstzspan` |

## Set types

Sets represent finite, sorted, uniqued collections of values of an
ordered base type.

| Type | Element type |
|---|---|
| `intset` | `int` |
| `bigintset` | `bigint` |
| `floatset` | `float` |
| `dateset` | `date` |
| `tstzset` | `timestamp with time zone` |
| `textset` | `text` |
| `geomset` | `geometry` |
| `geogset` | `geography` |

## Bounding-box types

Bounding boxes carry the spatial / value / temporal extent of a value
and are used for indexing and for fast disjointness checks.

| Type | Carries |
|---|---|
| `tstzspan` | temporal extent only — used for `tbool` and `ttext` |
| `tbox` | value extent (X) + temporal extent (T) — used for `tint` and `tfloat` |
| `stbox` | spatial extent (X, Y, optional Z) + temporal extent (T) — used for `tgeompoint`, `tgeogpoint`, `tgeometry`, `tgeography` |

## Optional / specialised types

These types are gated behind compile-time flags in MEOS so that
deployments can include only what they need. Each is exposed by its
respective binding when the corresponding flag is enabled.

| Type | Flag | Domain |
|---|---|---|
| `cbuffer` / `tcbuffer` | `-DCBUFFER=ON` | circular buffers (point + radius) and their temporal evolution |
| `npoint` / `tnpoint` | `-DNPOINT=ON` (default) | network-constrained points (along a road / network edge) and their temporal evolution |
| `pose` / `tpose` | `-DPOSE=ON` | rigid-body poses (position + orientation) and their temporal evolution |
| `rgeo` / `trgeo` | `-DRGEO=ON` (depends on `POSE`) | rigid geometries — geometries attached to a moving pose |

The catalog grows over time as new external base types are lifted to
their temporal counterparts. Bindings consume whatever MEOS exposes;
binding-specific availability follows the binding's own compile-time
flags.

For the conceptual model behind these types — instant / sequence /
sequence-set subtypes, discrete / linear / stepwise interpolation, and
how bounding boxes work — see the [Data Model](../datamodel/) page.
For the on-the-wire encoding of values of any type in this catalog,
see [Moving Feature Formats](/movingfeaturesformats/).
