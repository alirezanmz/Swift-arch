//
//  Rocket.swift
//  Star
//
//  Created by Alireza Namazi on 2/6/24.
//  https://api.spacexdata.com/v4/rockets

import Foundation

struct Rocket: Codable {
    let height, diameter: Diameter?
    let mass: Mass?
    let firstStage: FirstStage?
    let secondStage: SecondStage?
    let engines: Engines?
    let landingLegs: LandingLegs?
    let payloadWeights: [PayloadWeight]?
    let flickrImages: [String]?
    let name, type: String?
    let active: Bool?
    let stages, boosters, costPerLaunch, successRatePct: Int?
    let firstFlight, country, company: String?
    let wikipedia: String?
    let description, id: String?

    enum CodingKeys: String, CodingKey {
        case height, diameter, mass
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case engines
        case landingLegs = "landing_legs"
        case payloadWeights = "payload_weights"
        case flickrImages = "flickr_images"
        case name, type, active, stages, boosters
        case costPerLaunch = "cost_per_launch"
        case successRatePct = "success_rate_pct"
        case firstFlight = "first_flight"
        case country, company, wikipedia
        case description = "description"
        case id
    }
}
