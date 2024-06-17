#!/bin/bash
seq 20 | parallel -j 4 "echo {}; sleep 1"
