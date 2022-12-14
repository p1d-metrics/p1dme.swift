//
//  P1dme+Requests.swift
//

import Foundation

extension P1dme {
    func prepareCreateEventRequest() -> URLRequest {
        var eventsEndpoint: URL!
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
            eventsEndpoint = config.serviceURL.appending(components: "events")
        } else {
            eventsEndpoint = config.serviceURL.appendingPathComponent("events")
        }
        
        var request = URLRequest(url: eventsEndpoint)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(config.apiKey, forHTTPHeaderField: "p1dme-api-key")
        if let referer = referer {
            request.addValue(referer, forHTTPHeaderField: "Referer")
        }
        return request
    }
}
