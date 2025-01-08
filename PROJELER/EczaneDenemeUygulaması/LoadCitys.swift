//
//  LoadCitys.swift
//  EczaneDenemeUygulaması
//
//  Created by Furkan buğra karcı on 10.10.2024.
//

import Foundation
import SwiftUI
import Combine

class LoadCitys: ObservableObject {
    @Published var cities: [City] = []
    @Published var selectedCity: City? {
        didSet {
            updateDistricts() // Seçilen şehir değiştiğinde ilçeleri güncelle
        }
    }
    @Published var selectedDistrict: District?
    @Published var city: String = ""
    @Published var district: String = ""
    @Published var districts: [District] = [] // İlçeleri tutmak için

    init() {
        loadCities()
    }

    func loadCities() {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else { return }

        do {
            let data = try Data(contentsOf: url)
            var loadedCities = try JSONDecoder().decode([City].self, from: data)

            // "Lütfen il seçiniz" seçeneğini başa ekle
            let defaultCity = City(id: 0, text: "Lütfen il seçiniz", districts: [])
            loadedCities.insert(defaultCity, at: 0)

            self.cities = loadedCities
            self.selectedCity = defaultCity // Varsayılan olarak seçili değer
        } catch {
            print("Error loading JSON: \(error)")
        }
    }

    func updateDistricts() {
        if let selectedCity = selectedCity {
            districts = selectedCity.districts // Seçilen şehrin ilçelerini güncelle
        } else {
            districts = [] // Seçili şehir yoksa ilçeleri temizle
        }
    }
}
