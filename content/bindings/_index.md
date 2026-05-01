---
title: "MEOS Bindings"
date: 2024-08-20T13:54:25+02:00
draft: false
---

MEOS exposes its type system through bindings tailored to each host environment. Pick the binding that matches your stack.

## Database bindings

These bindings expose MEOS types as first-class types of a database or query engine, with full SQL support, indexing, and aggregation.

* **[PostgreSQL → MobilityDB](mobilitydb/)**
* **[DuckDB → MobilityDuck](mobilityduck/)**

## Language bindings

These bindings expose MEOS to general-purpose programming languages. Use them when you want to manipulate temporal data in application code rather than inside a database.

* **[Python → PyMEOS](pymeos/)**
* **[Java → JMEOS](jmeos/)**
* **[Rust → meos-rs](rustmeos/)**
* **[Go → GoMEOS](gomeos/)**
* **[.NET / C# → MEOS.NET](meosnet/)**
* **[JavaScript → MEOS.js](meosjs/)**

## Choosing a binding

| If you... | Use |
|---|---|
| have PostgreSQL in your stack | MobilityDB |
| use DuckDB or want embedded analytics | MobilityDuck |
| work in a Python notebook / data-science workflow | PyMEOS |
| build a Java / Kotlin / Scala / Clojure backend | JMEOS |
| build a Rust application | meos-rs |
| build a Go service | GoMEOS |
| build a .NET / Unity / desktop application | MEOS.NET |
| target the browser or Node.js | MEOS.js |

Bindings can be combined. A typical setup might use MobilityDB to store and query trajectories, PyMEOS to analyse them in a Jupyter notebook, and MEOS.js to visualise results in the browser. All three exchange data using MEOS's [encoding formats](/movingfeaturesformats/).
