---
title: "Moving Feature Formats"
date: 2022-07-29T14:28:47+02:00
draft: false
---

MEOS defines stable on-the-wire encodings for temporal values. These encodings are the common substrate that lets data round-trip between any two MEOS [bindings](/bindings/) without loss: a trajectory written from MobilityDB can be read by PyMEOS, JMEOS, MobilityDuck, and any other binding that consumes MEOS.

The library currently supports three encodings, each tuned for a different use case:

| Encoding | Use case | Form |
|---|---|---|
| [Well-Known Text (WKT)](wkt/) | human-readable, debugging, hand-authored fixtures | text |
| [Well-Known Binary (WKB)](wkb/) | canonical binary interchange, the densest representation | binary |
| [Moving-Features JSON (MF-JSON)](mfjson/) | OGC-aligned JSON, web APIs, cross-language readability | text (JSON) |

WKB is the canonical encoding for storage and inter-process transfer; WKT is the one users typically read and write by hand; MF-JSON is the one that travels well over REST / GraphQL / browser-side workflows.

All three encodings are *self-describing*: a value carries enough type information for the receiver to reconstruct the original temporal type without out-of-band metadata. Bindings can therefore exchange values with each other using any of the three formats and pick the format best-suited to the transport.
