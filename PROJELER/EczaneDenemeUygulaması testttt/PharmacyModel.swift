//
//  PharmacyModel.swift
//  EczaneDenemeUygulaması
//
//  Created by Furkan buğra karcı on 16.08.2024.
//

import Foundation

struct Pharmacy: Identifiable, Codable{
    var id = UUID() // Her eczane için benzersiz bir ID oluşturur
    let name: String?
    let dist: String?
    let address: String?
    let phone: String?
    let loc: String?

    // Sadece JSON'dan decode edilmesi gereken anahtarları tanımlayın
    enum CodingKeys: String, CodingKey {
        case name
        case dist
        case address
        case phone
        case loc
    }
}

struct PharmacyResponse: Codable {
    let success: Bool
    let result: [Pharmacy]?
}


