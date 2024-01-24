---
title: "Data Structures"
date: 2022-07-29T13:57:17+02:00
draft: false
---

Temporal Types
--------------

Although MEOS is written in C, it aims at using well-proven object-oriented concepts for its development. The 
 [data model]({{< ref "/documentation/datamodel" >}} "Data Model") for the temporal types is implemented using the following conceptual type hierarchy.

<img src="/images/temp_types.png" alt="Temporal type hierarchy" style="width: 50%;height: auto;"/>

The supertype `Temporal` is a *template* type since it is used for all temporal types, such as temporal integers or temporal points. `Temporal` is also an *abstract* type, since it cannot be instantiated, only its subtypes can. Temporal types are variable-length types: the size of an instance in bytes is kept in the `size` attribute. The specific type of an instance (such as `tint`or `tfloat`) is defined in the `temptype` attribute. The specific subtype of an instance (such as `TInstant`or `TSequence`) is specified in the `subtype` attribute. Finally, the `interpolation` attribute keeps the interpolation used, which can be discrete, linear, or stepwise.

The type `TInstant` is used for representing a *single observation* composed of a `value` and a timestamp `t`. Timestamps in MEOS keep associated time zone information and are stored using PostgreSQL [format](https://www.postgresql.org/docs/current/datatype-datetime.html), that is, in *microseconds* from January 1st, 2000 at 00:00:00 in Coordinated Universal Time (UTC), which is equal to Greenwich Mean Time (GMT). Notice that other systems, for example PostGIS [trajectories](https://postgis.net/docs/reference.html#Temporal), use [Unix time](https://en.wikipedia.org/wiki/Unix_time) in which time is represented in *milliseconds* from January 1st, 1970 at 00:00:00 UTC. In temporal instant values, the `flags` attribute specifies whether the `value` is passed by value or by reference, or whether the base type is discrete or continuous.

The type `TSequence` is used for representing a *set of observations* where an interpolation function is used for determining the value between observations. MEOS provides three interpolation functions: *discrete*, where the value is unknown between observations, *stepwise* where the value remains constant between consecutive observations, and *linear*, where the value evolves linearly between consecutive observations. For temporal sequence values, the `flags` attribute specifies the interpolation function used. The `count` attribute specifies the number of  observations, the `bbox` attribute specifies the bounding box that encompasses them, and the `instants` attribute keeps the observations. The bounding box can be of various types depending on the temporal type: 

*  for `tbool` and `ttext` it is a `period` keeping only the time extent,
*  for `tint` and `tfloat` it is a `TBox` composed of a `period` for the time extent and a `floatspan` for the value extent, and
*  for `tgeompoint` and `tgeogpoint` it is an `STBox` keeping a `period` for the time extent and the minimum and maximum values of the 2D/3D coordinates for the spatial extent.

The type `TSequenceSet` is used for representing a *set of sequences* having the same interpolation function that may have *temporal gaps* where the value is not known. This situation typically arrives in real-world applications due to signal loss. The `count` attribute specifies the number of such sequences, while the `totalcount` attribute specifies the number of observations across all sequences. Finally, the `bbox` attribute specifies the bounding box that encompasses all observations and the `sequences` attribute keeps the composing sequences.

The following figure shows the C structures implementing the above conceptual type hierarchy for temporal types.

<img src="/images/temp_struct.png" alt="Temporal structures" style="width: 60%;height: auto;"/>

The structures for all temporal types start with a `header`, which contains information in the `Temporal` supertype above shared for all subtypes. It is composed of the `size` (Z), `temptype` (T), `subtype` (S), and `flags` (F). The `flags` encodes metadata information such as whether the base values are passed by value or by reference, whether the base values are discrete (e.g., `int`) or continuous (e.g., `float`), the interpolation function used, whether the spatial values have a Z dimension, etc. 

The `TInstant` structure stores after the `header` the timestamp `t` and the base `value`.

The `TSequence` structure stores after the `header` the attributes `count` and `maxcount`, which state, respectively, the current and maximum number of composing values of type `TInstant`, `bboxsize` that stores the size of the bounding box, and `bbox` that stores the bounding box. As indicated in the figure, all bounding boxes start with a `period` for the time extent, and contain other attributes for temporal numbers (`TBox`) and temporal points (`STBox`). The structure contains an array of `òffsets`, storing the offset of the location of each composing instant with respect to the start of the structure. Therefore, the address of each composing instant can be easily obtained by adding its òffset to the address of the structure. The `òffsets` array also acts as a temporal index, since the instants are stored in ascending order of timestamp. This enables a binary search of the array, for example, when looking for the value at a given timestamp. This temporal index, combined with the bounding box that is used to quickly filter out values that do not satisfy a predicate, enables an efficient implementation of the temporal operations. Then, the structure stores the composing `instants`.

Finally, the `TSequenceSet` structure has similar structure as the `TSequence` structure, where `count` and `maxcount` state the current and maximum number of composing values of type `TSequence`, `totalcount` states the total number of instants accross all composing sequences, followed by the size of the bounding box `bboxsize`, the bounding box `bbox`, the `offsets` array, and the composing `sequences`.

Both the `TSequence` and `TSequenceSet` structures are expandable, that is, at the creation time they can allocate space available for storing additional observations later, as stated by the `count` and `maxcount` attributes. Furthermore, both structures automatically expand upon update operations when there is no more available space, where by default the size is doubled at each expansion. These features are essential for streaming applications. On the other hand, for historical (that is, batch) processing, the operations create structures without any additional space by simply calling the constructors with the same value for `count` and `maxcount`.

Set and Span Types
------------------

MEOS uses *set*, *span*, and *span set* types for representing finite subsets of values from the base and time types. These types are *template* types, since they are used for constructing multiple types. 

<img src="/images/setspan_classes.png" alt="Set and span classes" style="width: 50%;height: auto;"/>

The following figure shows the C structures for these types.

<img src="/images/setspan_struct.png" alt="Set and span structures" style="width: 50%;height: auto;"/>

The `Set` structure comes in two variants, depending on whether the values in the set are passed by value or by reference, depicted, respectively, in the topmost and the second structure. The `header` contains the `size` (Z), `settype` (B), `basetype` (B), and `flags` (F). Here, the `flags` encodes metadata information such as whether the values in the set are passed by value or by reference and whether the values in the set are stored in ascending order or not. The `bboxsize` attribute keeps the size of the bounding box and `bbox` stores the bounding box. As suggested by the dashed box, the bounding box may not be present, which is the case for alphanumeric values. For spatial values, the bounding box is a spatiotemporal box (`STBox`) keeping the minimum and maximum values of the 2D/3D coordinates for the spatial extent.

When the values in the set are passed by value, they are stored immediately after the bounding box. Otherwise, the structure contains an array of `òffsets`, storing the offset of the location of each value with respect to the start of the structure. Therefore, the address of each value can be easily obtained by adding its òffset to the address of the structure. Notice that the `òffsets` array is only necessary when the values of the set are of variable length, as is the case for the type `textset`, which contains `text` values. The `òffsets` array also act as an index when the set is ordered, since a binary search of the array is performed when looking for a given value. This index, combined with the bounding box that is used to quickly filter out values that do not satisfy a predicate, enables an efficient implementation of the set operations.

The `Span` structure starts with a `header`, composed of the `spantype` (S), `basetype` (B), `lower_inc` (L), and `upper_inc` (U), where the two latter elements state, respectively, whether the lower and upper bounds are inclusive or not. 
Then, the structure stores the values of the `lower`  and `upper` bounds.

Finally, the `SpanSet` structure starts with a `header`, composed of the `size` (Z), `spansettype` (T), `spantype` (S), and `basetype` (B). It is followed by the `count` attribute, which states the number of composing values of type `Span`, and the bounding `span`. The composing span values are kept in the `elems` array. Since the spans are stored in ascending order, this enables a binary search of the array when, for example, looking whether a given value is contained in the span set. Combined with the bounding box that is used to quickly filter out values that do not satisfy a predicate, this enables an efficient implementation of span set operations.

Bounding Box Types
------------------

MEOS uses *bounding boxes* for efficient manipulation of temporal types. For example, when determining whether a temporal point (e.g., a moving vehicle) overlaps a geometry (e.g., a county), a bounding box test is applied to quickly filter out the temporal points whose bounding box does not overlap the bounding box of the geometry. Then, the computation continues for the values satisfying the bounding box test. 

MEOS has three types of bounding boxes depicted next.

<img src="/images/boxes.png" alt="Bounding box types" style="width: 50%;height: auto;"/>

The `Span` type, already described above, is used for temporal types such as `tbool` and `ttext` and in this case the bounding box only represents the *temporal* extent of the value.

The `TBox` type is used for temporal numbers such as `tint` and `tfloat`, where the `span` attribute represents the *value* extent and the `period` attribute represents the *temporal* extent of the value.

Finally, the `STBox` type is used for temporal points such as `tgeompoint` and `tgeogpointt`, where the `period` attribute represents the *temporal* extent of the value, the attributes such as `xmin` and `xmax` represent the 2D or 3D spatial extent of the values, the attribute `srid` identifies the coordinate system, and the `flags` attribute keeps information such as whether the coordinate system is Cartesian or geodetic.
