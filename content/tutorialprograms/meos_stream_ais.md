---
title: "Stream Processing"
date: 2022-07-29T13:57:17+02:00
draft: false
---

[meos_stream_ais.c](https://github.com/estebanzimanyi/MobilityDB/blob/stops/meos/examples/04_meos_stream_ais.c)

A simple program that reads AIS data from a CSV file, accumulates the observations in main memory and send the temporal values to a MobilityDB database when they reach a given number of instants in order to free the memory and ingest the newest observations. The program uses the [libpq](https://www.postgresql.org/docs/current/libpq.html) library to connect to PostgreSQL.

The output of the program is given next.
```
Creating the table AISTrips in the database
Accumulating 1000 instants before sending them to the database
(one marker every database update)
**********************************************************************************************************
156837 records read.
0 incomplete records ignored.
Result of the query 'SELECT MMSI, public.numInstants(trip) FROM public.AISTrips;'

   mmsi    | numinstants
-----------+-------------
 257136000 |     20978
 219001559 |     35781
 566948000 |     23946
 219027804 |     16417
 265513270 |     7707
```
