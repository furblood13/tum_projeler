//
//  Result.swift
//  KpssPuanHesaplama
//
//  Created by Furkan buğra karcı on 6.10.2024.
//
import Foundation
import SwiftData

@Model
class Result: Identifiable {
    //Attribute koyma sebebimiz swiftdata kısmında da ıdnın unıque olduğunu belirtmek için
    @Attribute(.unique) let id = UUID()
    let sinavAdi: String
    let gyNet: Double
    let gkNet: Double
    let ebNet: Double?
    let oabtNet: Double?
    let tarih = Date()
    let sonuc: Double
    
    init(sinavAdi: String, gyNet: Double, gkNet: Double, ebNet: Double? = nil, oabtNet: Double? = nil, sonuc: Double) {
        self.sinavAdi = sinavAdi
        self.gyNet = gyNet
        self.gkNet = gkNet
        self.ebNet = ebNet
        self.oabtNet = oabtNet
        self.sonuc = sonuc
    }
}
