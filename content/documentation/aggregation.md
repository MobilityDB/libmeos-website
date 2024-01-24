---
title: "Aggregate Operations"
date: 2022-07-29T13:57:17+02:00
draft: false
---

We explain next the aggregate operations for temporal types. These operations use a [skip list](https://en.wikipedia.org/wiki/Skip_list) for their implementation.

Computation Model
-----------------

MEOS borrows from [PostgreSQL](https://www.postgresql.org/) the computation model for [aggregate operations](https://www.postgresql.org/docs/current/xaggr.html). These operations are defined in terms of *state values*, *state transition functions*, and *final functions*. An aggregate operation uses a *state value* that is updated as each successive input value is processed. The *data type* for the state value depends on the aggregate operation. It is a set or a span type when aggregating time values, or a temporal type when aggregating temporal values. The *state transition function* takes the previous state value and the aggregate's current value, and returns a new state value. A *final function* takes the ending state value and returns the aggregate result.

An example of usage of aggregate operations in MEOS is given [here](https://libmeos.org/tutorialprograms/meos_aggregate_berlinmod/).
 
Skip Lists
----------

We explain next the skip list structure implemented in MobilityDB for efficiently implementing temporal aggregate operations. The struture is illustrated in the figure below.

<img src="/images/skiplist.png" alt="Skip list structure" style="width: 60%;height: auto;"/>

The skip list structure contains the following elements.
`elemType` contains the type of elements stored in the skip list.
`capacity` is the maximum number of elements the skip list can currently store.
`next` is the index of the free next element.
`length` is the current number of values stored.
`freed` is an array containing the indexes of the elements deleted whose space can be reused.
`freecount` is the number of deleted elements.
`freecap` is the current size of the `freed` array.
`tail` is the index of the tail element of the list.
`extra` is a pointer to a structure containing additional information to be passed to the aggregate function. This is used when aggregating temporal points to keep the SRID and the dimensionality of the values.
`extrasize` is the size of the `extra` structure.
`elems` is an array containing the elements of the skip list.

As shown in the figure, to minimize memory allocation operations, the skip list uses a contiguous memory space for its elements. This is to contrast with an alternative implementation in which every element of the skip list is allocated individually as in the figure shown [here](https://en.wikipedia.org/wiki/Skip_list#/media/File:Skip_list.svg). Each element contains a value (shown in the yellow boxes), its current height, and an array of pointers (of size four in the figure) to other elements. Due to its memory structure, the pointers between skip list elements are not actually pointers, but values of the index of the element pointed to. This is implied in the figure by the dashed arrows. The grayed cells in the figure show unused pointers, that is, those whose index is greater that the current height of the element. The array of skip list elements is an expandable struture, it will expand automatically when it is full.

In the figure, the values 1 to 10 represent timestamps. In this case, the values stored in the skip list are passed by value and thus the skip list element contains the value. If on the contrary, the values stored in the skip list are passed by reference, as is the case for spans or for temporal values, a pointer to the address where the structure is located will be stored as value of the element. 

The figure below shows the contents of the skip list after removing the element with value 9. As can be seen, the array `freed` contains the indexes of the elements deleted and whose space can be reused.

<img src="/images/skiplist_delete.png" alt="Skip list delete" style="width: 60%;height: auto;"/>


Finally, the next figure shows the contents of the skip list after inserting the element with value 11. 

<img src="/images/skiplist_insert.png" alt="Skip list insert" style="width: 60%;height: auto;"/>

As can be seen, the free value from the previous delete is reused when inserting a new value. If there are no more free values to be reused, the new value will be stored at the next available place of the structure and the pointers will be updated similarly.