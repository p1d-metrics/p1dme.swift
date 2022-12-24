#!/bin/sh

swift package --allow-writing-to-directory ./docs generate-documentation --target P1dme --disable-indexing --transform-for-static-hosting --hosting-base-path p1dme.swift --output-path docs
