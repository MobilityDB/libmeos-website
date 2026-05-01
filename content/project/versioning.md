---
title: "Versioning & Stability"
date: 2026-05-01T00:00:00Z
draft: false
---

MEOS makes explicit stability commitments so that bindings, downstream
applications, and persisted data can rely on the library across
releases.

## C API stability

The public C API exposed by `meos.h` follows
[Semantic Versioning](https://semver.org/) (semver):

| Version bump | What changes |
|---|---|
| **Patch** (`x.y.Z`) | Bug fixes, internal refactoring. No source-level or ABI changes. |
| **Minor** (`x.Y.0`) | New functions / types. Existing function signatures and ABI remain compatible — code written against an older minor version compiles and links against a newer one in the same major series. |
| **Major** (`X.0.0`) | Source / ABI breaks allowed. Migration notes ship with the release. |

Functions that are **deprecated** in a minor version remain usable
through the rest of that major series and are removed only at the next
major bump.

## Wire-format stability

Every encoding MEOS defines (WKT, [WKB](/movingfeaturesformats/wkb/),
[MF-JSON](/movingfeaturesformats/mfjson/)) carries its own version
number, evolved independently of the C API:

* **Forward compatibility** — readers refuse to load a value whose
  encoding-version major number is higher than they support, with a
  clear error.
* **Backward compatibility** — readers accept any value whose
  encoding-version is the same major and any lower-or-equal minor.
* **Versioning of footer metadata** — when MEOS encodings are
  embedded in a higher-level container format (for example, Parquet
  files using the [TemporalParquet](/movingfeaturesformats/) footer
  convention), the container's footer carries its own version
  alongside the encoding version.

A value written by any MEOS-consuming binding can be read by any other
binding linked against a compatible MEOS major version.

## Type-catalog stability

The [type catalog](/documentation/typecatalog/) grows over time as new
base types are lifted to their temporal counterparts. Adding a new
type is a *minor* version bump (the C API gains new functions but
existing ones are unaffected). Removing a type is a *major* version
bump and is preceded by at least one minor-version cycle of
deprecation.

## Binding compatibility

Each binding declares the MEOS major version it supports. Bindings are
not required to release in lockstep with MEOS; a typical pattern is
that a binding's `x.y` release supports MEOS `MAJOR` for some declared
range. See each binding's documentation for its specific compatibility
statement.
