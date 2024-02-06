//
//  ISP.swift
//  Star
//
//  Created by Alireza Namazi on 2/6/24.
//

import Foundation

// MARK: - ISP
struct ISP: Codable {
    let seaLevel, vacuum: Int?

    enum CodingKeys: String, CodingKey {
        case seaLevel = "sea_level"
        case vacuum
    }
}
