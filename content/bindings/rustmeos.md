---
title: "RustMEOS"
date: 2024-09-11T12:26:38+02:00
draft: false
---

[RustMEOS](https://crates.io/crates/meos) is a crate that wraps the MEOS C library, providing a high level interface to the underlying C functionality, without compromising in performance.

RustMEOS exposes the functionality of MEOS and is meant to be used directly by the user.

## Disclaimer

The crate is still in alpha, this means it is not advised for production usage as some tests are still to be added and not proper CI workflows are inplace. 

Only a subset of `meos` has been implemented, feel free to add wrappers for missing features.

All added features needs to be tested and this being a C wrapper, valgrind runs on all examples/tests to check that
no bugs / memory leaks are lurking.

## Links

GitHub repository: https://github.com/MobilityDB/RustMEOS

Examples: https://github.com/MobilityDB/RustMEOS/tree/main/examples

Documentation: https://docs.rs/meos/0.1.2/meos/