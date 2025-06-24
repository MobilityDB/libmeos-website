---
title: "Assembling Trips"
date: 2022-07-29T13:57:17+02:00
draft: false
---

[03_ais_assemble.c](https://github.com/MobilityDB/MobilityDB/blob/master/meos/examples/03_ais_assemble.c)

This program reads AIS data from a CSV file, constructs trips from these records, and outputs for each trip the MMSI, the number of instants, and the distance travelled.

The output of the program is given next.
```
156837 records read.
0 incomplete records ignored.
5 trips read.
MMSI: 265513270, Number of input instants: 21799, Number of instants: 6, Distance travelled 11.695976
MMSI: 219027804, Number of input instants: 38326, Number of instants: 3285, Distance travelled 64865.704162
MMSI: 566948000, Number of input instants: 26619, Number of instants: 2969, Distance travelled 14932.332003
MMSI: 219001559, Number of input instants: 48323, Number of instants: 1597, Distance travelled 5202.381849
MMSI: 257136000, Number of input instants: 21770, Number of instants: 14811, Distance travelled 647535.585339
```
The above ouput shows the *normalization* process that takes place in MEOS. In the first example above, from 21799 observations only 6 of them were necessary to represent the same information. Normalization achieves lossless compression by removing redundant instants. For example, three consecutive instant values can be merged into two if they have the same value. As another example, three consecutive instant values can be merged into two if the linear functions defining the evolution of values over time are the same. Normalization may achieve up to 400% lossless compression of real-world mobility data. Indeed, many observations that are collected, e.g., while a vehicle is stopped at a red light or in a traffic jam are redudant and can be safely removed without losing any information.

A similar result can be obtained in MobilityDB with the following SQL query, assuming that the CSV file has been previously loaded into the `AISInput` table.
```sql
WITH temp1(MMSI, NoInputInst) AS (
  SELECT MMSI, COUNT(*)
  FROM AISInput
  GROUP BY MMSI ),
temp2(MMSI, trip) AS (
  SELECT MMSI, tgeogpoint_seq(array_agg(tgeogpoint_inst(
    ST_SetSRID(ST_Point(longitude, latitude), 4326), t) ORDER BY t))
  FROM AISInput
  GROUP BY MMSI )
SELECT t1.MMSI, NoInputInst, numInstants(trip) AS NoInst, 
  to_char(length(trip), '999990D999999') AS Distance
FROM temp1 t1, temp2 t2
WHERE t1.MMSI = t2.MMSI;
```

