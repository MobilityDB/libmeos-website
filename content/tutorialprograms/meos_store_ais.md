---
title: "Storing in MobilityDB"
date: 2022-07-29T13:57:17+02:00
draft: false
---

[meos_store_ais.c](https://github.com/MobilityDB/MobilityDB/blob/develop/meos/examples/04_meos_store_ais.c)

This program reads AIS data from a CSV file, converts them into temporal values, and stores them in MobilityDB. The program uses the [libpq](https://www.postgresql.org/docs/current/libpq.html) library to connect to PostgreSQL.

The output of the program is given next.
```
Creating the table in the database
NOTICE:  table "aisinstants" does not exist, skipping
Start processing the file
156837 records read.
0 incomplete records ignored.
Query 'SELECT COUNT(*) FROM public.AISInstants' returned 156837
```

A similar result can be obtained in MobilityDB with the following SQL query, assuming that the CSV file has been previously loaded into the `AISInput` table.
```sql
CREATE TABLE public.AISInstants(MMSI integer, location public.tgeogpoint, SOG public.tfloat);
INSERT INTO AISInstants(MMSI, location, SOG)
SELECT MMSI, tgeogpoint_inst(ST_SetSRID(ST_Point(longitude, latitude), 4326), t), tfloat_inst(sog, t)
FROM AISInput;
SELECT COUNT(*) FROM AISInput;
```
