---
title: "Well-Known Text (WKT)"
date: 2022-07-29T14:22:43+02:00
draft: false
---

“Well-known text” is a scheme for writing moving features into a standard text string. It is an extension of the scheme for writing a [simple features ](https://en.wikipedia.org/wiki/Simple_Features)geometry into a [standard text string](https://libgeos.org/specifications/wkt/).



### WKT BNF

For ease of presentation we suppose the following standard types: `<integer>`, `<float>`, `<string>`, and `<timestamp with timezone>`;
 
- Span types
``` 
<comma> ::= ','
<left paren> ::= '('
<right paren> ::= ')'
<left bracket> ::= '['
<right bracket> ::= ']'
<left brace> ::= '{'
<right brace> ::= '}'
<left bound> := <left bracket> | <left paren>
<right bound> := <right bracket> | <right paren>

<int span wkt> ::= <left bound> <integer> <comma> <integer> <right bound>
<float span wkt> ::= <left bound> <float> <comma> <float> <right bound>
<period wkt> ::= <left bound> <timestamp with timezone> <comma> <timestamp with timezone> <right bound>
<span wkt> ::= <int span wkt> | <float span wkt> | <period wkt>
``` 

- Time set types
``` 
<timestamp set wkt> ::=
  <left brace> <timestamp with timezone> {<comma> <timestamp with timezone>} ... <right brace>
<period set wkt> ::=
  <left brace> <period wkt> {<comma> <period wkt>} ... <right brace>
<time set wkt> ::= <timestamp set wkt> | <period set wkt> 
``` 

- Box types
```
<x> := 'X'
<t> := 'T'
<xt> := 'XT'
<tbox> ::= 'TBOX'
<tbox xt> ::= <tbox> <xt> <left paren> <float span> <comma> <period> <right paren>
<tbox x> ::= <tbox> <x> <left paren> <float span> <right paren>
<tbox t> ::= <tbox> <t> <left paren> <period> <right paren>
<tbox wkt> ::= <tbox xt> | <tbox x> | <tbox t>

<srid> ::= 'SRID'
<equal> ::= '='
<semicolon> ::= ';'
<srid specification> ::= <srid> <equal> <integer> <semicolon>
<srid wkt> ::= <srid specification> <semicolon>
<x coord> ::= <float>
<y coord> ::= <float>
<z coord> ::= <float>
<coords> ::= <x coord> <y coord> [ <z coord> ]
<coords bound> := <left paren> <x coord> <comma> <y coord> [ <comma> <z coord> ] <right paren>
<coords span> ::= <left paren> <coords bound> <comma> <coords bound> <right paren> 

<z> := 'Z'
<zt> := 'ZT'
<xz> := <x> | <z>
<xzt> := <xt> | <zt>
<stbox> ::= 'STBOX' | 'GEODSTBOX'
<stbox st> ::= <stbox> <xzt> <left paren> <coords span> <comma> <period> <right paren>
<stbox s> ::= <stbox> <xz> <left paren> <coords span> <right paren>
<stbox t> ::= <stbox> <t> <left paren> <period> <right paren>
<stbox wkt> ::= <stbox st> | <stbox s> | <stbox t>

<bounding box wkt> ::= <period wkt> | <tbox wkt> | <stbox wkt>
``` 

- Temporal types
```
/* Temporal base types */

<double quote> := '"'
<bool wkt> = 'true' | 't' | 'false' | 'f'
<point> := 'POINT'
<int wkt> ::= <integer>
<float wkt> ::= <float>
<text wkt> := <double quote> <string> <double quote>
<point wkt> ::= [ <srid wkt> ] <point> [ <z> ] <left paren> <coords> <right paren>
<temporal base wkt> ::= <bool wkt> | <int wkt> | <float wkt> | <text wkt> | <point wkt>

/* Temporal instant */

<at> ::= '@'
<tinstant> ::= <temporal base wkt> <at> <t>
<tpoint instant> ::= <point wkt> <at> <t>

<tinstant wkt> ::= <tinstant> | <tpoint instant>

/* Temporal sequence */

<tsequence discrete> ::=
  <left brace> <tinstant wkt> {<comma> <tinstant wkt>} ... <right brace>
<tpoint sequence discrete> ::=
  [ <srid wkt> ] <left brace> <tpoint instant wkt> {<comma> <tpoint instant wkt>} ... <right brace>

<interpolation> ::= 'Interp'
<interpolation function> ::= 'Stepwise'
<interpolation specification> ::= <interpolation> <equal> <interpolation function>
<interpolation wkt> ::= <interpolation specification> <semicolon>
<srid interpolation wkt> ::= <interpolation wkt> | <srid wkt> |
  <srid specification> <comma> <interpolation specification> <semicolon>
<tsequence continuous> ::=
  [ <interpolation wkt> ] <left bound> <tinstant wkt> {<comma> <tinstant wkt>} ... <right bound>
<tpoint sequence continuous> ::=
  [ <srid interpolation wkt> ] <left bound> <tpoint instant wkt> {<comma> <tpoint instant wkt>} ... <right bound>

<tsequence wkt> ::= <tsequence discrete> | <tpoint sequence discrete> |
  <tsequence continuous> | <tpoint sequence continuous>

/* Temporal sequence set */

<tsequence set> ::=
  [ <interpolation wkt> ] <left brace> <tsequence wkt> {<comma> <tsequence wkt>} ... <right brace>
<tpoint sequence set> ::=
  [ <srid interpolation wkt> ] <left brace> <tpoint sequence wkt> {<comma> <tpoint sequence wkt>} ... <right brace>

<tsequence set wkt> ::= <tsequence set>  | <tpoint sequence set> 

/* Temporal type */

<temporal wkt> ::=  <tinstant wkt> | <tsequence wkt> | <tsequence set wkt>

```


## Examples of values

- Span types
```
"[19, 21]"
"(74, 83)"
"[59.14400641946122, 67.4557671439834)"
"(42.34679828863591, 50.27122142305598]"
"[2001-04-26 09:11:00+02, 2001-04-26 09:18:00+02]"
"[2001-03-14 20:43:00+01, 2001-03-14 20:51:00+01)"
```

- Time types
```
"{2001-01-23 08:13:00+01, 2001-01-23 08:16:00+01, 2001-01-23 08:19:00+01}"
"{2001-01-23 08:13:00+01}"
"{(2001-05-29 11:20:00+02, 2001-05-29 11:21:00+02], (2001-05-29 11:24:00+02, 2001-05-29 11:27:00+02)}"
"{(2001-10-18 19:46:00+02, 2001-10-18 19:50:00+02)}"
```

- Box types 
```
"TBOX XT([85.631867, 89.408875],[2001-09-07 00:20:00+02, 2001-09-07 00:26:00+02])"
"TBOX X([85.631867, 89.408875])"
"TBOX T([2001-09-07 00:20:00+02, 2001-09-07 00:26:00+02])"
"STBOX XT(((30.266616,74.668954),(32.743667,84.470892)),[2001-11-19 12:39:00+01, 2001-11-19 12:46:00+01])"
"SRID=5676;STBOX X(((30.266616,74.668954),(32.743667,84.470892)))"
"STBOX T(([2001-11-19 12:39:00+01, 2001-11-19 12:46:00+01])"
"STBOX ZT(((53.986894,30.334541,42.518891),(56.040446,37.764663,49.610776)),[2001-08-14 12:26:00+02, 2001-08-14 12:28:00+02])"
"STBOX Z(((53.986894,30.334541,42.518891),(56.040446,37.764663,49.610776)))"
"STBOX T([2001-08-14 12:26:00+02, 2001-08-14 12:28:00+02])"
"SRID=4326;GEODSTBOX ZT(((18.055912,63.50315,827.645472),(21.462877,65.39722,832.587446)),[2001-02-12 15:48:00+01, 2001-02-12 15:56:00+01])
```

- Temporal types
```
/* Temporal instant */

"true@2022-01-01 08:00:00+02"
"1@2022-01-01 08:00:00+02"
"2.5@2022-01-01 08:00:00+02"
"walking@2022-01-01 08:00:00+02"
"POINT(0 0)@2022-01-01 08:00:00+02"
"SRID=5676;Point(1 1)@2022-01-01 08:00:00+02"

/* Temporal discrete sequence */

"{true@2022-01-01 08:00:00+02, false@2022-01-01 08:10:00+02} "
"{1@2022-01-01 08:00:00, 2@2022-01-01 09:00:00+02}"
"SRID=5676;{POINT(1 1)@2022-01-01 08:00:00+02, POINT(2 2)@2022-01-01 09:00:00+02}"

/* Temporal continuous sequence

"[1@2022-01-01 08:00:00+02, 2@2022-01-01 09:00:00+02, 1@2022-01-01 09:30:00+02]"
"Interp=Stepwise;[1@2022-01-01 08:00:00+02, 2@2022-01-01 09:00:00+02, 1@2022-01-01 09:30:00]+02"
"[POINT(1 1)@2022-01-01 08:00:00+02, POINT(2 2)@2022-01-01 09:00:00+02]"
"SRID=5676;[POINT(1 1)@2022-01-01 08:00:00+02, POINT(2 2)@2022-01-01 09:00:00+02]"
"Interp=Stepwise;[POINT(1 1)@2022-01-01 08:00:00+02, POINT(2 2)@2022-01-01 09:00:00+02]"
"SRID=5676,Interp=Stepwise;[POINT(1 1)@2022-01-01 08:00:00+02, POINT(2 2)@2022-01-01 09:00:00+02]"

/* Temporal sequence set */

"{[driving@2022-01-01 08:00:00+02, driving@2022-01-01 09:00:00+02], [walking@2022-01-01 10:00:00+02, walking@2022-01-01 11:00:00+02]}"
"{[POINT(1 1)@2022-01-01 08:00:00+02, POINT(2 2)@2022-01-01 09:00:00+02], [POINT(3 3)@2022-01-01 10:00:00+02, POINT(3 3)@2022-01-01 11:00:00+02]}"
"SRID=5676;{[POINT(1 1)@2022-01-01 08:00:00+02, POINT(2 2)@2022-01-01 09:00:00+02], [POINT(3 3)@2022-01-01 10:00:00+02, POINT(3 3)@2022-01-01 11:00:00+02]}"
```


### Writing WKT

Because WKT is a decimal text output, it will never be able to exactly represent the underlying machine representation of floating point number and in particular coordinates of temporal point. In general, WKT is used for display to humans, or for transport when exact coordinate representation is not required (some web applications).

Accordingly, MEOS allows you to customize the coordinate precision and rounding behaviour, as well as the dimensionality of WKT output.


```
/* Read an instant */
const char *wkt_in = "Point(1 1 1,2 2 2)@2022-01-01";
TInstant *inst = tgeompoint_from_text(inst_str);

/* 
 * Generate the output WKT
 * The first argument sets the number places after the decimal to output in WKT. Default 16.
 * The second argument sets the number of dimension to output in WKT. Default is as in the data.
 */
  unsigned char *wkt = tgeompoint_as_text(inst, 6, 2);

/* Continue processing ... */

/* Free the allocated memory */
free(wkt_in);
free(wkt_out);
free(inst);
```

