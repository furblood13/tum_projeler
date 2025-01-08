//
//  IlIlceModel.swift
//  EczaneDenemeUygulaması
//
//  Created by Furkan buğra karcı on 10.10.2024.
//

import Foundation

struct District: Codable, Identifiable,Hashable {
    let id: Int
    let text: String

    enum CodingKeys: String, CodingKey {
        case id = "value"
        case text
    }
}

struct City: Codable, Identifiable,Hashable {
    let id: Int
    let text: String
    let districts: [District]

    enum CodingKeys: String, CodingKey {
        case id = "value"
        case text
        case districts
    }
}
