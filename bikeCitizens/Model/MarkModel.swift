//
//  MarkModel.swift
//  bikeCitizens
//
//  Created by Paul on 27.02.22.
//

import Foundation

struct MarkModel: Codable {
    let markID: String
    let name: String
    let summary: String
    let lat, lon: Double
    let iconURL: String
    var isFavorite: Bool = false

    enum CodingKeys: String, CodingKey {
        case name, summary, lat, lon
        case iconURL = "icon_url"
        case markID = "id"
    }
}
