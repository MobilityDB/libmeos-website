---
title: "Developer's Documentation"
date: 2022-07-29T13:34:19+02:00
draft: false
---

The developer's documentation is available at [docs.libmeos.org](http://docs.libmeos.org/)

Alternatively, you can generate the English developer's documentation in HTML format from the source: 


```bash
  git clone --branch develop https://github.com/MobilityDB/MobilityDB MobilityDB
  mkdir MobilityDB/build
  cd MobilityDB/build
  cmake -DMEOS=on -DDOC_DEV=on ..
  make -j
  make doc_dev
```

The resulting HTML documentation will be generated in the doxygen directory of the build directory.