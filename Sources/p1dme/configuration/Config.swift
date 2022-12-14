//
//  Config.swift
//

import Foundation

struct Config {
    let applicationId: String
    let serviceURL: URL
    let apiKey: String
    
    public enum Errors: Error {
        case invalid(bundle: Bundle, fileName: String)
        case invalid(serviceUrl: String)
        case invalid(applicationId: String)
        case invalid(apiKey: String)
    }
}

extension Config {
    static func parse(bundle: Bundle, fileName: String) throws -> Config {
        do {
            return try ConfigData.parse(bundle: bundle, fileName: fileName)
        } catch {
            throw error
        }
    }
}
