---
title: "Modification Operations"
date: 2022-07-29T13:57:17+02:00
draft: false
---

We explain next the semantics of the modification operations for temporal types. These operations are needed for streaming applications where the observations arrive not necessarily ordered by time. The assumption is that most observations arrive ordered by time and thus, inserting in the middle of a temporal value is an exceptional operation. In this case, we need to push the subsequent instants in the extensible array using a `memmove` operation in C, which is a costly operation. If on the contrary, the observations would arrive in a random order with respect to time, the extensible array data structure used in MobilityDB is not the right data structure, instead a [linked list](https://en.wikipedia.org/wiki/Linked_list) or a [skip list](https://en.wikipedia.org/wiki/Skip_list) of instants should be used. For example, in MobilityDB skip lists are used for [temporal aggregation](https://libmeos.org/documentation/aggregation/) operations since by definition the temporal values to aggregate come in random order of time.

MEOS provides the `insert`, `update`, and `delete` operations for modifying the content of an existing sequence or sequence set. As a comparison, PostGIS provides the following update operations for modifying an existing line string: 
[ST_AddPoint](https://postgis.net/docs/ST_AddPoint.html), 
[ST_SetPoint](https://postgis.net/docs/ST_SetPoint.html), and
[ST_RemovePoint](https://postgis.net/docs/ST_RemovePoint.html).

First, we explain the case of inserting or updating an instant or a sequence to an existing sequence, as illustrated next.

<img src="/images/meos_update_sequence.png" alt="Update sequence" style="width: 40%;height: auto;"/>

As shown in the figure, we are adding the temporal sequence (or a temporal instant if `n = 1`) in the top of the figure to an existing sequence in the bottom of the figure. When `vi@ti` is the last instant of the sequence, we are adding the new sequence to the end of the existing sequence (this corresponds to an append operation). 

We start by explaining the `insert` operation. In this case, it is supposed that `ti <= t1` and `tn <= ti+1`, otherwise an error is thrown. A particular case that must be taken into account is when `ti = t1` and/or `tn = ti+1`. In this case, the semantics depends on the operation performed. In the case of an `insert`, it is necessary that `vi = v1` and `vn = vi+1`, otherwise an error is thrown. If the constraint is satisfied, the `insert` does not add the redundant connecting instants. In the case of an `update`, the values of the connecting instants are updated if they are different. In the general case, if `ti < t1` and/or `tn < ti+1`, then the new instants are added to the sequence. 

On the other hand, when performing an `update` operation, the above constraint `ti <= t1` and `tn <= ti+1` is not required and therefore, the resulting sequence will contain the values in the new sequence, independently of the previous values it had (if any) between the timestamps `t1` and `tn`.

Finally, when performing a `delete` operation, it removes the instants between two timestamps `tstart` and `tend` passed as parameters, where an additional parameter of the function states whether the values before and after the given timestamps are connected, or on the contrary a temporal gap is added to the sequence, resulting in a sequence set.

We now explain the case of inserting or updating an instant or a sequence to an existing sequence set. The case of inserting or updating an existing sequence amounts to the previous case. What remains to be explained is to add a sequence in a temporal gap between two sequences or at the end of a sequence, as illustrated next.

<img src="/images/meos_update_sequenceset.png" alt="Update sequence set" style="width: 40%;height: auto;"/>

As shown in the figure, we are adding the temporal sequence in the top of the figure to a temporal gap in (or at the end of) an existing sequence in the bottom of the figure. 

As before, in the case of an `insert` or an `update` operation, it is supposed that `ti <= t1` and `ti+1 >= tn`, otherwise an error is thrown. When `ti = t1` and/or `tn = ti+1`, we are extending the sequence to the left and/or to the right of the temporal gap and we proceed as explained above. Otherwise, when `ti < t1` and `tn < ti+1`, three different operations can be contemplated, depending on the value of an additional parameter of the `insert` or `update` functions. We can either extend the sequence to the left and/or to the right of the gap, or simply add the new sequence in the gap, leaving two gaps to the left and to the right of the new sequence.

When performing a `replace` operation, the above constraint `ti <= t1` and `tn <= ti+1` is not required and therefore, the resulting sequence set will contain the values in the new sequence, independently of the previous values it had (if any) between the timestamps `t1` and `tn`. Notice that if `t1 <= ti` and/or `ti+1 <= tn` the operation fills (partially or completely) the temporal gap.


Finally, when performing a `delete` operation, it removes the instants between two timestamps `tstart` and `tend` passed as parameters, where an additional parameter of the function states whether the values before and after the given timestamps are connected, or on the contrary a temporal gap is added to the sequence set.
