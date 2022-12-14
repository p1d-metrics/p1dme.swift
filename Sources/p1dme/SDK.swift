//
//  SDK.swift
//  

// Enforce minimum Swift version for all platforms and build systems.
#if swift(<5.5)
#error("This SDK (P1d.metrics) doesn't support Swift versions below 5.5.")
#endif

/// Current P1dme version.
let version = "1.0.0"
