#!/bin/sh

swift package --allow-writing-to-directory ./docs generate-documentation --target P1dme --output-path ./docs --transform-for-static-hosting --hosting-base-path p1dme.swift 
