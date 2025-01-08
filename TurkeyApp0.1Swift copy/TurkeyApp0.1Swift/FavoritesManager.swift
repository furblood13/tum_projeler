//
//  FavoritesManager.swift
//  TurkeyApp0.1Swift
//
//  Created by Furkan buğra karcı on 9.12.2024.
//

import Foundation
import SwiftUI
import MapKit

class FavoritesManager: ObservableObject {
    @Published var favoritePlaces: [MKMapItem] = []
    
    // Favorilere yer ekleme fonksiyonu
    func addToFavorites(place: MKMapItem) {
        if !favoritePlaces.contains(where: { $0.placemark.coordinate.latitude == place.placemark.coordinate.latitude &&
                                             $0.placemark.coordinate.longitude == place.placemark.coordinate.longitude }) {
            favoritePlaces.append(place)
        }
    }
    func removeFavorite(place: MKMapItem) {
        if let index = favoritePlaces.firstIndex(of: place) {
            favoritePlaces.remove(at: index)
        }
    }

}
