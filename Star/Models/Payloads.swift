//
//  Payloads.swift
//  Star
//
//  Created by Alireza Namazi on 2/6/24.
//

import Foundation

// MARK: - Payloads
struct Payloads: Codable {
    let compositeFairing: CompositeFairing?
    let option1: String?

    enum CodingKeys: String, CodingKey {
        case compositeFairing = "composite_fairing"
        case option1 = "option_1"
    }
}
