//
//  P1Device.swift
//

import Foundation

final class P1Device {
    static func getPlarformArchitecture() -> String {
        #if arch(arm)
            return "arm"
        #elseif arch(arm64)
            return "arm64"
        #elseif arch(i386)
            return "i386"
        #elseif arch(powerpc64)
            return "powerpc64"
        #elseif arch(powerpc64le)
            return "powerpc64le"
        #elseif arch(s390x)
            return "s390x"
        #elseif arch(wasm32)
            return "wasm32"
        #elseif arch(x86_64)
            return "x86_64"
        #else
            return "unknown_machine_architecture"
        #endif
    }
}
