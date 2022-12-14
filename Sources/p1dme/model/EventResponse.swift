//
//  EventResponse.swift
//

import Foundation

struct EventResponse: Codable {
    let serverTime: Double
    let event: EventDetails
}
