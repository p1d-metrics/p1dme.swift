//
//  URLRequest.swift
//

import Foundation

#if canImport(UIKit)
import UIKit
#endif

extension URLRequest {
    mutating func addPlatformAnalytics() {
        addArchitectureHeader()
        addPlatformHeaders()
        addDeviceModelHeader()
        addIsMobileHeader()
    }
    
    private mutating func addArchitectureHeader() {
        setValue(P1Device.getPlarformArchitecture(), forHTTPHeaderField: "Sec-CH-UA-Arch")
    }
    
    private mutating func addPlatformHeaders() {
        var platform: String?
        var platformVersion: String?
        
        #if canImport(UIKit) && !os(watchOS)
        platform = UIDevice.current.systemName
        #endif
        
        #if os(watchOS)
        platform = "watchOS"
        #endif
        
        #if os(macOS)
        platform = "macOS"
        #endif
        
        let version = ProcessInfo.processInfo.operatingSystemVersion
        platformVersion = "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
        
        if let platform = platform {
            setValue(platform, forHTTPHeaderField: "Sec-CH-UA-Platform")
        }
        if let platformVersion = platformVersion {
            setValue(platformVersion, forHTTPHeaderField: "Sec-CH-UA-Platform-Version")
        }
    }
    
    private mutating func addDeviceModelHeader() {
        var deviceModel: String?
        
        #if canImport(UIKit) && !os(watchOS)
        deviceModel = UIDevice.current.model
        #endif
        
        #if os(watchOS)
        deviceModel = "Watch"
        #endif
        
        #if os(macOS)
        var macDeviceName: String? {
            return "hw.model".withCString { hwModelCStr in
                var size = 0
                if sysctlbyname(hwModelCStr, nil, &size, nil, 0) != 0 {
                    return nil
                }
                precondition(size > 0)
                var resultCStr = [CChar](repeating: 0, count: size)
                if sysctlbyname(hwModelCStr, &resultCStr, &size, nil, 0) != 0 {
                    return nil
                }
                return String(cString: resultCStr)
            }
        }
        if let macDeviceName = macDeviceName {
            deviceModel = macDeviceName
        }
        #endif
        
        if let deviceModel = deviceModel {
            setValue(deviceModel, forHTTPHeaderField: "Sec-CH-UA-Model")
        }
    }
    
    private mutating func addIsMobileHeader() {
        setValue("false", forHTTPHeaderField: "Sec-CH-UA-Mobile")
        
        #if os(iOS) || os(watchOS)
            #if !targetEnvironment(macCatalyst)
            setValue("true", forHTTPHeaderField: "Sec-CH-UA-Mobile")
            #endif
        #endif
    }
}
