---
title: "Data Model"
date: 2022-07-29T13:57:17+02:00
draft: false
---

Temporal Types
--------------

MEOS provides **temporal types**, which represent the evolution on time of values of some element type, called the **base type** of the temporal type. For instance, a temporal integer may be used to represent the evolution on time of the gear used by a moving car. In this case, the data type is temporal integer and the base type is integer. Similarly, a temporal float may be used to represent the evolution on time of the speed of a car. As another example, a temporal point may be used to represent the evolution on time of the location of a car, as reported by GPS devices. Temporal types are useful because representing values that evolve in time is essential in many applications, especially in mobility applications. Furthermore, the operators on the base types (such as arithmetic operators for integers and floats, spatial relationships and distance for geometries) can be intuitively generalized when the values evolve in time.

MEOS has six built-in temporal types, namely `tbool`, `tint`, `tfloat`, `ttext`, `tgeompoint`, and `tgeogpoint`, which are, respectively, based on [PostgreSQL](https://www.postgresql.org/) alphanumeric types `bool` (a Boolean value), `int` (a 4-byte integer number), `float` (an 8-byte floating point number), and `text` (a string of characters of variable size), as well as the geospatial base types `geometry`, and `geography` from [PostGIS](https://postgis.net/) restricted to 2D or 3D points with Z dimension.

The **interpolation** of a temporal value states how the value evolves between successive instants. The interpolation is **discrete** when the value is unknown between two successive instants. They can represent, for example, checkins/checkouts when using an RFID card reader to enter/exit a building. The interpolation is **linear** when the value evolves linearly between two successive instants. For example, the speed of a car may be represented with a temporal float, which indicates that the values are known at the two time instants but continuously evolve between them. Similarly, the location of a vehicule may be represented by a temporal point where the location between two consecutive GPS readings is obtained by linear interpolation. Finally, the interpolation is **stepwise** when the value remains constant between two successive instants. For example, the gear used by a moving car may be represented with a temporal integer, which indicates that its value is constant between two time instants. Temporal types based on **discrete base types** (that is `tbool`, `tint`, or `ttext`) may evolve in a discrete or stepwise manner. On the other hand, temporal types based on **continuous base types** (that is `tfloat`, `tgeompoint`, or `tgeogpoint`) may evolve in a discrete, linear, or stepwise manner.

The **subtype** of a temporal value states the temporal extent at which the evolution of values is recorded. Temporal values come in thee subtypes, explained next.

A temporal value of **instant** subtype (briefly, an instant value) represents the value at a time instant, for example

`'17@2018-01-01 08:00:00'`

A temporal value of **sequence** subtype (briefly, a sequence value) represents the evolution of the value during a sequence of time instants, where the values between these instants are interpolated using either a discrete, a linear, or a stepwise function (see above). A graphical represention of sequence values with the three interpolations are given next.

<img src="/images/interpolation_seq.png" alt="Temporal sequence values" style="width: 30%;height: auto;"/>

Examples of values for the three interpolations are given next:
```
-- Discrete interpolation
'{17@2018-01-01 08:00:00, 17.5@2018-01-01 08:05:00, 18@2018-01-01 08:10:00}'
-- Linear interpolation
'(10@2018-01-01 08:00:00, 20@2018-01-01 08:05:00, 15@2018-01-01 08:10:00]'
-- Stepwise interpolation
'Interp=Stepwise;(10@2018-01-01 08:00:00, 20@2018-01-01 08:05:00, 15@2018-01-01 08:10:00]'
```

As can be seen, a sequence value has a lower and an upper bound that can be either inclusive, represented by `[` and `]`, or exclusive, represented by `(` and `)`. By definition, both bounds must be inclusive when the interpolation is discrete or when the sequence has a single instant such as `'[10@2018-01-01 08:00:00]'`. The latter is called an **instantaneous** sequence.

The value of a temporal sequence with linear or stepwise interpolation is interpreted by assuming that the period of time defined by every pair of consecutive values `v1@t1` and `v2@t2` is lower inclusive and upper exclusive, unless they are the first or the last instants of the sequence and in that case the bounds of the whole sequence apply. Furthermore, the value taken by the temporal sequence between two consecutive instants depends on whether the interpolation is linear or stepwise. For example, the temporal sequence above

`'(10@2018-01-01 08:00:00, 20@2018-01-01 08:05:00, 15@2018-01-01 08:10:00]'`

represents that the value evolves from `10` to `20` during `(2018-01-01 08:00:00, 2018-01-01 08:05:00)` and evolves from `20` to `15` during `[2018-01-01 08:05:00,2018-01-01 08:10:00]`. On the other hand, the temporal sequence above

`'Interp=Stepwise;(10@2018-01-01 08:00:00, 20@2018-01-01 08:05:00, 15@2018-01-01 08:10:00]'`

represents that the value is `10` during `(2018-01-01 08:00:00, 2018-01-01 08:05:00)`, `20` during `[2018-01-01 08:05:00,2018-01-01 08:10:00)`, and `15` at the end instant `2018-01-01 08:10:00`. 

Finally, a temporal value of **sequence set** subtype (briefly, a sequence set value) represents the evolution of the value at a set of sequences, where the values between these sequences are unknown. A graphical represention of sequence set values with different interpolations are given next.

<img src="/images/interpolation_seqset.png" alt="Temporal sequence set values" style="width: 60%;height: auto;"/>

As shown above, sequence set values can only be of linear or stepwise interpolation. Furtheremore, all composing sequences of a sequence set value must be of the same interpolation.

Examples of sequence set values are as follows:

```
-- Linear Interpolation
'{[17@2018-01-01 08:00:00, 17.5@2018-01-01 08:05:00], [18@2018-01-01 08:10:00, 18@2018-01-01 08:15:00]}'
-- Stepwise Interpolation
'Interp=Stepwise;{[17@2018-01-01 08:00:00, 17.5@2018-01-01 08:05:00], [18@2018-01-01 08:10:00, 18@2018-01-01 08:15:00]}'
```

A rich set of functions is available to perform various operations on temporal types. The developer's documentation available at [docs.libmeos.org](http://docs.libmeos.org/) give a detailed description of these functions.

Each temporal type is associated to another type, referred to as its **bounding box**, which represent its extent in the value and/or the time dimension. The bounding box of the various temporal types are as follows: 

- The `tstzspan` type (see below) for the `tbool` and `ttext` types, where only the temporal extent is considered.
- A `TBox` (temporal box) type for the `tint` and `tfloat` types, where the value extent is defined in the X dimension and the temporal extent in the T dimension.
- An `STBox` (spatiotemporal box) type for the `tgeompoint` and `tgeogpoint` types, where the spatial extent is defined in the X, Y, and Z dimensions (where the Z dimension is optional), and the temporal extent in the T dimension.

Set and Span Types
------------------

MEOS provides **span** and **span set** types (corresponding to PostgreSQL [range and multirange types](https://www.postgresql.org/docs/current/rangetypes.html)) for defining ranges of values. Examples of span types are `intspan`, `floatspan`, and `tstzspan`, which represent, respectively, ranges of integer, float, and timestamp with time zone values. Examples of values for the span types are as follows.

```
-- Integer span
'[17, 18)'
-- Float span
'(17.5, 18.5]'
-- Timestamp with time zone span
'[2018-01-01 08:00:00, 2018-01-01 08:10:00]'
```

Examples of span set types are `intspanset`, `floatspanset`, and `tstzspanset`, which represent sets of spans. Examples of values for the span types are as follows.
```
-- Integer span set
'{[17, 18), [19, 20)}'
-- Float span set
'{[17.5, 18.5), [19.5, 20.5)}'
-- Timestamp with time zone span set
'{[2018-01-01 08:00:00, 2018-01-01 08:10:00], [2018-01-01 08:20:00, 2018-01-01 08:30:00]}'
```

MEOS also provides **set** types for representing set of values. Examples of set types are `intset`, `floatset`, and `tstzset`, which represent, respectively, set of integer, float, and timestamp with time zone values. Examples of values for the set types are as follows.
```
-- Integer set
'{17, 18, 19, 20}'
-- Float set
'{17.5, 18.5, 19.5, 20.5}'
-- Timestamp with time zone set
'{2018-01-01 08:00:00, 2018-01-01 08:10:00, 2018-01-01 08:20:00, 2018-01-01 08:30:00}'
```

Finally, MEOS also provides PostgreSQL [date/time types](https://www.postgresql.org/docs/current/datatype-datetime.html), namely, `Timestamp`, `TimestampTz`, `DateADT`, `Time`, and `Interval`, in addition to the base types `bool`, `int`, `float`, and `text`.




