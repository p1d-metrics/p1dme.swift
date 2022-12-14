//
//  EventDetails.swift
//

import Foundation

/// A complete event as stored in the (remote) service
public struct EventDetails: Codable {
    /// ID of the application as defined in the configuration file
    public private(set) var applicationId: String
    /// ID of this event (server side)
    public private(set) var metricId: String
    /// Timestamp when the event was processed
    public private(set) var serverTime: Double
    /// ID of the installation of the application in the user device
    public private(set) var installationId: String
    
    /// Name of this event
    public private(set) var event: String
    /// Category of this event
    public private(set) var category: String? = nil
    /// Additional parameters that describe aspects of this event
    public private(set) var parameters: [String: String]? = nil
    /// Country of the user device. Obtain from HTTP Headers by service
    public private(set) var country: String? = nil
    /// Language of the user device. Obtain from HTTP Headers by service
    public private(set) var language: String? = nil
    /// Referer. In the iOS / macOS SDK is the Bundle ID of the application
    public private(set) var referer: String? = nil
    /// General information about the device where the event was generated
    public private(set) var device: Device? = nil
    
    private enum CodingKeys: String, CodingKey {
        case applicationId
        case metricId
        case serverTime
        case installationId
        case event
        case category
        case parameters
        case country
        case language
        case referer
        case device
    }
}

/// Basic information about the device, included in every `EventDetails`
public struct Device: Codable {
    /// Device's platform. i.e.: iOS, macOS, tvOS, watchOS
    public private(set) var platform: String? = nil
    /// Version of the platform (OS). i.e.: 16.0.0
    public private(set) var platformVersion: String? = nil
    /// Architecture of this device. i.e.: arm,  arm64, i386, x86_64
    public private(set) var arch: String? = nil
    /// Model of this device. i.e.: iPhone, iPad, Mac Mini
    public private(set) var model: String? = nil
    /// True if it's a mobile device (iPhone, iPad, Apple Watch). False if it's a computer or TV
    public private(set) var mobile: Bool = false
}
