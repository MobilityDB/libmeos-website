---
title: "Moving Features JSON (MF-JSON)"
date: 2022-07-29T14:23:01+02:00
draft: false
---

“Moving Features JSON” is a standard for encoding moving features in [JSON](https://en.wikipedia.org/wiki/JSON). By using MF-JSON, rather than some other arbitrary scheme, you maximize the interoperability of your JSON output. MF-JSON is an Open Geospatial Consortium [standard](https://docs.opengeospatial.org/is/19-045r3/19-045r3.html), which extends the [GeoJSON](https://geojson.org/) standard.

### Examples


- {"type":"MovingBoolean","values":true,"datetimes":"2000-01-01T00:00:00","interpolations":["Discrete"]}
- {"type":"MovingInteger","values":2,"datetimes":"2000-01-01T00:00:00","interpolations":["Discrete"]}
- {"type":"MovingFloat","values":2.5,"datetimes":"2000-01-01T00:00:00","interpolations":["Discrete"]}
- {"type":"MovingText","values":"walking","datetimes":"2000-01-01T00:00:00","interpolations":["Discrete"]}
- {"type":"MovingPoint","coordinates":[1,1],"datetimes":"2000-01-01T00:00:00","interpolations":["Discrete"]}
- {"type":"MovingPoint","crs":{"type":"name","properties":{"name":"EPSG:5676"}},"coordinates":[1,1],"datetimes":"2000-01-01T00:00:00","interpolations":["Discrete"]}
- {"type":"MovingInteger","values":[1,2],"datetimes":["2022-01-01T08:00:00","2022-01-01T09:00:00"],"interpolations":["Discrete"]}
- {"type":"MovingPoint","coordinates":[[1,1],[2,2]],"datetimes":["2022-01-01T08:00:00","2022-01-01T09:00:00"],"lower_inc":true,"upper_inc":true,"interpolations":["Linear"]}
- {"type":"MovingText","sequences":[{"values":["driving","driving"],"datetimes":["2022-01-01T08:00:00","2022-01-01T09:00:00"],"lower_inc":true,"upper_inc":true},{"values":["walking","walking"],"datetimes":["2022-01-01T10:00:00","2022-01-01T11:00:00"],"lower_inc":true,"upper_inc":true}],"interpolations":["Stepwise"]}
- {"type":"MovingPoint","sequences":[{"coordinates":[[1,1],[2,2]],"datetimes":["2022-01-01T08:00:00","2022-01-01T09:00:00"],"lower_inc":true,"upper_inc":true},{"coordinates":[[3,3],[3,3]],"datetimes":["2022-01-01T10:00:00","2022-01-01T11:00:00"],"lower_inc":true,"upper_inc":true}],"interpolations":["Linear"]}

