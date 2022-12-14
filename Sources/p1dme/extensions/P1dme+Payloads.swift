//
//  P1dme+Payloads.swift
//

import Foundation

extension P1dme {
    func preparePayload(event: String, category: String?, parameters: [String:String]?) -> [String:Any] {
        var payload = [String: Any]()
        payload["applicationId"] = config.applicationId
        payload["installationId"] = installationId
        payload["event"] = event
        if let category = category, !category.isEmpty {
            payload["category"] = category
        }
        if let parameters = parameters, !parameters.isEmpty {
            payload["parameters"] = parameters
        }
        return payload
    }
}
