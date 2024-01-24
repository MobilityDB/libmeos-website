---
title: "Reading from File"
date: 2022-07-29T13:57:17+02:00
draft: false
---

[meos_read_ais.c](https://github.com/MobilityDB/MobilityDB/blob/develop/meos/examples/02_meos_read_ais.c)

This program reads AIS data from a CSV file and outputs a few of these records converted into temporal values.

The output of the program is given next.
```
MMSI: 566948000, Location: POINT(4.62 55.57)@2021-01-08 01:10:46+01 SOG : 0.5@2021-01-08 01:10:46+01
MMSI: 566948000, Location: POINT(4.62 55.57)@2021-01-08 01:21:25+01 SOG : 0.1@2021-01-08 01:21:25+01
MMSI: 219001559, Location: POINT(9.98 57.59)@2021-01-08 01:33:48+01 SOG : 0.1@2021-01-08 01:33:48+01
...
MMSI: 219001559, Location: POINT(9.98 57.59)@2021-01-09 00:43:35+01 SOG : 0@2021-01-09 00:43:35+01
MMSI: 566948000, Location: POINT(4.49 55.64)@2021-01-09 00:52:34+01 SOG : 0.3@2021-01-09 00:52:34+01

156837 records read.
0 incomplete records ignored.
```

A similar result can be obtained in MobilityDB with the following SQL commands.
```sql
SET timezone = 'UTC';
CREATE TABLE public.AISInput(t TimestampTz, MMSI integer, latitude float, longitude float, sog float);
COPY AISInput(t, MMSI, latitude, longitude, sog) FROM '/home/MobilityDB/meos/examples/aisinput.csv' CSV HEADER;
SELECT MMSI, asText(tgeompoint_inst(ST_Point(longitude, latitude), t)), tfloat_inst(sog, t)
FROM AISInput;
```

