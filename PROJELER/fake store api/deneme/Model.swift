//
//  Model.swift
//  deneme
//
//  Created by Furkan buğra karcı on 15.08.2024.
//

import Foundation

// Rating Model
struct Rating: Codable, Identifiable {
    var id = UUID()
    let rate: Double
    let count: Int

    enum CodingKeys: String, CodingKey {
        case rate
        case count
    }
}

// Product Model
struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
}

