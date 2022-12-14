//
//  ConfigData.swift
//  

import Foundation

struct ConfigData: Decodable {
    private enum CodingKeys: String, CodingKey {
        case applicationId
        case serviceURL
        case apiKey
    }

    let applicationId: String
    let serviceURL: String
    let apiKey: String
}

extension ConfigData {
    static func parse(bundle: Bundle, fileName: String) throws -> Config {
        let decoder = PropertyListDecoder()
        guard let url = bundle.url(forResource: fileName, withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let configData = try? decoder.decode(ConfigData.self, from: data) else {
            throw Config.Errors.invalid(bundle: bundle, fileName: fileName)
        }
        guard let serviceURL = URL(string: configData.serviceURL) else {
            throw Config.Errors.invalid(serviceUrl: configData.serviceURL)
        }
        let appId = configData.applicationId.trimmingCharacters(in: .whitespacesAndNewlines)
        let apiKey = configData.apiKey.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !appId.isEmpty else {
            throw Config.Errors.invalid(applicationId: configData.applicationId)
        }
        guard !apiKey.isEmpty else {
            throw Config.Errors.invalid(apiKey: configData.apiKey)
        }
        
        return Config(applicationId: appId,
                      serviceURL: serviceURL,
                      apiKey: apiKey)
    }
}
