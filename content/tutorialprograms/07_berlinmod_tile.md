---
title: "Tiling Trips"
date: 2022-07-29T13:57:17+02:00
draft: false
---

[07_berlinmod_tile.c](https://github.com/MobilityDB/MobilityDB/blob/master/meos/examples/07_berlinmod_tile.c)

This program reads a CSV file containing synthetic trip data in Brussels generated by the [MobilityDB-BerlinMOD](https://github.com/MobilityDB/MobilityDB-BerlinMOD) generator, splits the trips and the speed of these trips by tiles, and computes aggregate values of the count, duration, and distance of the tiles.

The output of the program is given next.
```
Processing records
*******************************************************
55 records read.
0 incomplete records ignored.
-------------
 Trip tiles
-------------
Tile: (0,0), Box: SRID=3857;STBOX X(((470000,6575000),(475000,6580000))), Count: 8, Duration: 00:19:46.615846, Distance: 10.786511
Tile: (0,4), Box: SRID=3857;STBOX X(((490000,6575000),(495000,6580000))), Count: 4, Duration: 00:04:04.031572, Distance: 1.604871
Tile: (0,6), Box: SRID=3857;STBOX X(((470000,6580000),(475000,6585000))), Count: 8, Duration: 00:22:18.779158, Distance: 16.538983
Tile: (1,0), Box: SRID=3857;STBOX X(((475000,6580000),(480000,6585000))), Count: 8, Duration: 01:31:49.677269, Distance: 53.885458
Tile: (1,1), Box: SRID=3857;STBOX X(((480000,6580000),(485000,6585000))), Count: 8, Duration: 01:49:33.714171, Distance: 37.778044
Tile: (1,2), Box: SRID=3857;STBOX X(((485000,6580000),(490000,6585000))), Count: 8, Duration: 00:45:04.538618, Distance: 22.131790
Tile: (1,3), Box: SRID=3857;STBOX X(((490000,6580000),(495000,6585000))), Count: 16, Duration: 01:20:51.078422, Distance: 32.945149
Tile: (1,4), Box: SRID=3857;STBOX X(((495000,6580000),(500000,6585000))), Count: 8, Duration: 00:27:20.533366, Distance: 32.372265
Tile: (1,6), Box: SRID=3857;STBOX X(((475000,6585000),(480000,6590000))), Count: 8, Duration: 01:04:37.100221, Distance: 21.461376
Tile: (2,0), Box: SRID=3857;STBOX X(((480000,6585000),(485000,6590000))), Count: 8, Duration: 00:50:10.544733, Distance: 25.760025
Tile: (2,1), Box: SRID=3857;STBOX X(((485000,6585000),(490000,6590000))), Count: 8, Duration: 01:10:56.856836, Distance: 38.339253
Tile: (2,2), Box: SRID=3857;STBOX X(((490000,6585000),(495000,6590000))), Count: 8, Duration: 00:26:10.436406, Distance: 14.058617
Tile: (2,3), Box: SRID=3857;STBOX X(((495000,6585000),(500000,6590000))), Count: 8, Duration: 00:38:18.048761, Distance: 43.095820
Tile: (2,6), Box: SRID=3857;STBOX X(((480000,6590000),(485000,6595000))), Count: 8, Duration: 01:23:20.018189, Distance: 39.784050
Tile: (3,0), Box: SRID=3857;STBOX X(((485000,6590000),(490000,6595000))), Count: 8, Duration: 01:11:47.367447, Distance: 48.640160
Tile: (3,1), Box: SRID=3857;STBOX X(((490000,6590000),(495000,6595000))), Count: 12, Duration: 01:02:57.574739, Distance: 33.033053
Tile: (3,2), Box: SRID=3857;STBOX X(((495000,6590000),(500000,6595000))), Count: 14, Duration: 01:07:06.635146, Distance: 54.751272
Tile: (3,5), Box: SRID=3857;STBOX X(((480000,6595000),(485000,6600000))), Count: 18, Duration: 02:56:21.041016, Distance: 90.521896
Tile: (3,6), Box: SRID=3857;STBOX X(((485000,6595000),(490000,6600000))), Count: 8, Duration: 00:34:53.294617, Distance: 21.691950
Tile: (4,0), Box: SRID=3857;STBOX X(((490000,6595000),(495000,6600000))), Count: 8, Duration: 00:39:38.783947, Distance: 28.283381
Tile: (4,1), Box: SRID=3857;STBOX X(((495000,6595000),(500000,6600000))), Count: 23, Duration: 01:49:57.921917, Distance: 67.974290
Tile: (4,3), Box: SRID=3857;STBOX X(((475000,6600000),(480000,6605000))), Count: 10, Duration: 00:55:28.209348, Distance: 13.240459
Tile: (4,4), Box: SRID=3857;STBOX X(((480000,6600000),(485000,6605000))), Count: 10, Duration: 00:39:04.266773, Distance: 17.265266
Tile: (4,5), Box: SRID=3857;STBOX X(((485000,6600000),(490000,6605000))), Count: 8, Duration: 00:47:58.754216, Distance: 36.384378
Tile: (4,6), Box: SRID=3857;STBOX X(((490000,6600000),(495000,6605000))), Count: 16, Duration: 02:33:50.892969, Distance: 71.120467
Tile: (5,0), Box: SRID=3857;STBOX X(((495000,6600000),(500000,6605000))), Count: 8, Duration: 00:44:19.986058, Distance: 27.253547
Tile: (5,5), Box: SRID=3857;STBOX X(((490000,6605000),(495000,6610000))), Count: 22, Duration: 00:50:45.16079, Distance: 34.812390
Tile: (5,6), Box: SRID=3857;STBOX X(((495000,6605000),(500000,6610000))), Count: 2, Duration: 00:01:28.891909, Distance: 0.887142

-------------
 Speed tiles
-------------
Tile: (0,0), Span: [0, 10), Period: [2020-06-01 00:00:00+02, 2020-06-02 00:00:00+02), Count: 15, Duration: 04:22:34.710424
Tile: (0,1), Span: [10, 20), Period: [2020-06-01 00:00:00+02, 2020-06-02 00:00:00+02), Count: 15, Duration: 02:41:13.617439
Tile: (0,2), Span: [20, 30), Period: [2020-06-01 00:00:00+02, 2020-06-02 00:00:00+02), Count: 8, Duration: 00:16:14.737605
Tile: (0,3), Span: [30, 40), Period: [2020-06-01 00:00:00+02, 2020-06-02 00:00:00+02), Count: 5, Duration: 00:10:19.359894
Tile: (1,0), Span: [0, 10), Period: [2020-06-02 00:00:00+02, 2020-06-03 00:00:00+02), Count: 12, Duration: 03:41:45.691217
Tile: (1,1), Span: [10, 20), Period: [2020-06-02 00:00:00+02, 2020-06-03 00:00:00+02), Count: 12, Duration: 02:36:48.00074
Tile: (1,2), Span: [20, 30), Period: [2020-06-02 00:00:00+02, 2020-06-03 00:00:00+02), Count: 8, Duration: 00:16:31.4621
Tile: (1,3), Span: [30, 40), Period: [2020-06-02 00:00:00+02, 2020-06-03 00:00:00+02), Count: 4, Duration: 00:10:18.383576
Tile: (2,0), Span: [0, 10), Period: [2020-06-03 00:00:00+02, 2020-06-04 00:00:00+02), Count: 14, Duration: 03:50:32.840146
Tile: (2,1), Span: [10, 20), Period: [2020-06-03 00:00:00+02, 2020-06-04 00:00:00+02), Count: 14, Duration: 02:40:39.675611
Tile: (2,2), Span: [20, 30), Period: [2020-06-03 00:00:00+02, 2020-06-04 00:00:00+02), Count: 9, Duration: 00:16:10.08588
Tile: (2,3), Span: [30, 40), Period: [2020-06-03 00:00:00+02, 2020-06-04 00:00:00+02), Count: 6, Duration: 00:10:20.669972
Tile: (3,0), Span: [0, 10), Period: [2020-06-04 00:00:00+02, 2020-06-05 00:00:00+02), Count: 14, Duration: 03:51:02.500427
Tile: (3,1), Span: [10, 20), Period: [2020-06-04 00:00:00+02, 2020-06-05 00:00:00+02), Count: 14, Duration: 02:39:02.330412
Tile: (3,2), Span: [20, 30), Period: [2020-06-04 00:00:00+02, 2020-06-05 00:00:00+02), Count: 7, Duration: 00:16:10.821293
Tile: (3,3), Span: [30, 40), Period: [2020-06-04 00:00:00+02, 2020-06-05 00:00:00+02), Count: 5, Duration: 00:10:15.867724
```

A similar result can be obtained in MobilityDB with the following SQL queries, assuming that the CSV file has been previously loaded into the `trips` table.
```sql
WITH temp1(extent) AS (
  SELECT extent(trip) FROM  trips ),
temp2 AS (
  SELECT (g).index, (g).box
  FROM (SELECT multidimGrid(extent, 5e3) AS g FROM temp1 ) t )
SELECT index, box, SUM(1) AS count,
  SUM(duration(atSTbox(trip, box))) AS duration,
  SUM(length(atSTbox(trip, box))) / 1e3 AS distance
FROM trips, temp2
WHERE atSTbox(trip, box) IS NOT NULL
GROUP BY index, box
ORDER BY index;

WITH temp1(extent) AS (
  SELECT extent(speed(trip)) FROM  trips ),
temp2 AS (
  SELECT (g).index, (g).box
  FROM (SELECT multidimGrid(extent, 10, '1 day', 0, '2020-06-01') AS g FROM temp1 ) t )
SELECT index, box::floatspan AS span, box::period AS period,
  SUM(1) AS count, SUM(duration(atTbox(speed(trip), box))) AS duration
FROM trips, temp2
WHERE atTbox(speed(trip), box) IS NOT NULL
GROUP BY index, box
ORDER BY index;
```
