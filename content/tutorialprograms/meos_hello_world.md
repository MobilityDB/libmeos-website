---
title: "My First MEOS Program"
date: 2022-07-29T13:57:17+02:00
draft: false
---

[meos_hello_world.c](https://github.com/MobilityDB/MobilityDB/blob/develop/meos/examples/01_meos_hello_world.c)

This program creates some temporal values from their WKT format and output them in MF-JSON format.

The output of the program is given next.
```
--------------------
| Temporal Instant |
--------------------

WKT:
----
POINT(1 1)@2000-01-01

MF-JSON:
--------
{
   "type": "MovingGeomPoint",
   "stBoundedBy": {
     "bbox": [
       [
         1,
         1
       ],
       [
         1,
         1
       ]
     ],
     "period": {
       "begin": "2000-01-01T00:00:00+01",
       "end": "2000-01-01T00:00:00+01"
     }
   },
   "coordinates": [
     1,
     1
   ],
   "datetimes": "2000-01-01T00:00:00+01",
   "interpolations": [
     "Discrete"
   ]
 }

-------------------------------------------------
| Temporal Sequence with Discrete Interpolation |
-------------------------------------------------
WKT:
----
{POINT(1 1)@2000-01-01, POINT(2 2)@2000-01-02}

MF-JSON:
--------
{
   "type": "MovingGeomPoint",
   "stBoundedBy": {
     "bbox": [
       [
         1,
         1
       ],
       [
         2,
         2
       ]
     ],
     "period": {
       "begin": "2000-01-01T00:00:00+01",
       "end": "2000-01-02T00:00:00+01"
     }
   },
   "coordinates": [
     [
       1,
       1
     ],
     [
       2,
       2
     ]
   ],
   "datetimes": [
     "2000-01-01T00:00:00+01",
     "2000-01-02T00:00:00+01"
   ],
   "lower_inc": true,
   "upper_inc": true,
   "interpolations": [
     "Discrete"
   ]
 }

-----------------------------------------------
| Temporal Sequence with Linear Interpolation |
-----------------------------------------------
WKT:
----
[POINT(1 1)@2000-01-01, POINT(2 2)@2000-01-02]

MF-JSON:
--------
{
   "type": "MovingGeomPoint",
   "stBoundedBy": {
     "bbox": [
       [
         1,
         1
       ],
       [
         2,
         2
       ]
     ],
     "period": {
       "begin": "2000-01-01T00:00:00+01",
       "end": "2000-01-02T00:00:00+01"
     }
   },
   "coordinates": [
     [
       1,
       1
     ],
     [
       2,
       2
     ]
   ],
   "datetimes": [
     "2000-01-01T00:00:00+01",
     "2000-01-02T00:00:00+01"
   ],
   "lower_inc": true,
   "upper_inc": true,
   "interpolations": [
     "Linear"
   ]
 }

-------------------------------------------------
| Temporal Sequence with Stepwise Interpolation |
-------------------------------------------------
WKT:
----
Interp=Stepwise;[POINT(1 1)@2000-01-01, POINT(2 2)@2000-01-02]

MF-JSON:
--------
{
   "type": "MovingGeomPoint",
   "stBoundedBy": {
     "bbox": [
       [
         1,
         1
       ],
       [
         2,
         2
       ]
     ],
     "period": {
       "begin": "2000-01-01T00:00:00+01",
       "end": "2000-01-02T00:00:00+01"
     }
   },
   "coordinates": [
     [
       1,
       1
     ],
     [
       2,
       2
     ]
   ],
   "datetimes": [
     "2000-01-01T00:00:00+01",
     "2000-01-02T00:00:00+01"
   ],
   "lower_inc": true,
   "upper_inc": true,
   "interpolations": [
     "Stepwise"
   ]
 }

---------------------------------------------------
| Temporal Sequence Set with Linear Interpolation |
---------------------------------------------------
WKT:
----
{[POINT(1 1)@2000-01-01, POINT(2 2)@2000-01-02],[POINT(3 3)@2000-01-03, POINT(3 3)@2000-01-04]}

MF-JSON:
--------
{
   "type": "MovingGeomPoint",
   "stBoundedBy": {
     "bbox": [
       [
         1,
         1
       ],
       [
         3,
         3
       ]
     ],
     "period": {
       "begin": "2000-01-01T00:00:00+01",
       "end": "2000-01-04T00:00:00+01"
     }
   },
   "sequences": [
     {
       "coordinates": [
         [
           1,
           1
         ],
         [
           2,
           2
         ]
       ],
       "datetimes": [
         "2000-01-01T00:00:00+01",
         "2000-01-02T00:00:00+01"
       ],
       "lower_inc": true,
       "upper_inc": true
     },
     {
       "coordinates": [
         [
           3,
           3
         ],
         [
           3,
           3
         ]
       ],
       "datetimes": [
         "2000-01-03T00:00:00+01",
         "2000-01-04T00:00:00+01"
       ],
       "lower_inc": true,
       "upper_inc": true
     }
   ],
   "interpolations": [
     "Linear"
   ]
 }

-----------------------------------------------------
| Temporal Sequence Set with Stepwise Interpolation |
-----------------------------------------------------
WKT:
----
Interp=Stepwise;{[POINT(1 1)@2000-01-01, POINT(2 2)@2000-01-02],[POINT(3 3)@2000-01-03, POINT(3 3)@2000-01-04]}

MF-JSON:
--------
{
   "type": "MovingGeomPoint",
   "stBoundedBy": {
     "bbox": [
       [
         1,
         1
       ],
       [
         3,
         3
       ]
     ],
     "period": {
       "begin": "2000-01-01T00:00:00+01",
       "end": "2000-01-04T00:00:00+01"
     }
   },
   "sequences": [
     {
       "coordinates": [
         [
           1,
           1
         ],
         [
           2,
           2
         ]
       ],
       "datetimes": [
         "2000-01-01T00:00:00+01",
         "2000-01-02T00:00:00+01"
       ],
       "lower_inc": true,
       "upper_inc": true
     },
     {
       "coordinates": [
         [
           3,
           3
         ],
         [
           3,
           3
         ]
       ],
       "datetimes": [
         "2000-01-03T00:00:00+01",
         "2000-01-04T00:00:00+01"
       ],
       "lower_inc": true,
       "upper_inc": true
     }
   ],
   "interpolations": [
     "Stepwise"
   ]
 }
```
The above ouput uses the pretty-printing options provided by the `json-c` library to facilite human reading. By changing the corresponding flag in the program it is possible to obtain a more compact machine-processable representation.

A similar result can be obtained in MobilityDB with the following SQL query.
```sql
WITH temp(k, t) AS (
  SELECT 1, tgeompoint 'POINT(1 1)@2000-01-01' UNION
  SELECT 2, tgeompoint '{POINT(1 1)@2000-01-01, POINT(2 2)@2000-01-02}' UNION
  SELECT 3, tgeompoint '[POINT(1 1)@2000-01-01, POINT(2 2)@2000-01-02]' UNION
  SELECT 4, tgeompoint '{[POINT(1 1)@2000-01-01, POINT(2 2)@2000-01-02], [POINT(3 3)@2000-01-03, POINT(3 3)@2000-01-04]}'
)
SELECT asEWKT(t), asMFJSON(t,1) FROM temp
ORDER BY k;
```

