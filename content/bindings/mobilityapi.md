---
title: "HTTP / OGC API"
date: 2026-05-01T00:00:00Z
draft: false
---

MobilityAPI is the HTTP API server that exposes MEOS-stored data through the [OGC API – Moving Features](https://docs.ogc.org/is/22-003r3/22-003r3.html) standard. It provides REST endpoints (GET / POST / PUT / DELETE) over collections of moving features, suitable for HTTP-driven clients that don't speak SQL or the PostgreSQL wire protocol — browser applications, mobile clients, microservices, ETL pipelines, and any other consumer that wants temporal data over plain HTTP.

The reference implementation runs on top of MobilityDB; the architecture is backend-agnostic and the same server can in principle front any MEOS-aware SQL engine — including [MobilityDuck](mobilityduck/) — using identical OGC endpoints.

## Resources

* GitHub: https://github.com/MobilityDB/MobilityAPI
