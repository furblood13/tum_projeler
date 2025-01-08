//
//  FavoritesView.swift
//  TurkeyApp0.1Swift
//
//  Created by Furkan buğra karcı on 9.12.2024.
//

import SwiftUI
import MapKit

struct FavoritesView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager
    
    var body: some View {
        NavigationView {
            ZStack {
                // Arka plan gradyanı
                LinearGradient(
                    gradient: Gradient(colors: [.mor, .yesil]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea() // Gradyanın tüm ekranı kaplaması
                
                // Liste içeriği
                List {
                    ForEach(favoritesManager.favoritePlaces, id: \.self) { place in
                        Button(action: {
                            openInAppleMaps(place: place)
                        }) {
                            Text(place.name ?? "Unknown Place")
                                .font(.headline)
                                .foregroundColor(.black) // Yazı rengini beyaz yap
                        }
                    }
                    .onDelete(perform: deletePlace)
                }
                .scrollContentBackground(.hidden) // Listenin arka planını şeffaf yap
                .background(Color.clear) // Listenin arka planını temizle
            }
            .navigationTitle("Favoriler")
            .navigationBarTitleDisplayMode(.inline)
            //.navigationBarHidden(true) // Navigation barı gizle
             // Başlık göstermek için

        }
    }
    
    // Silme fonksiyonu
    func deletePlace(at offsets: IndexSet) {
        for index in offsets {
            let place = favoritesManager.favoritePlaces[index]
            favoritesManager.removeFavorite(place: place)
        }
    }
    
    // Apple Maps'te yeri açma fonksiyonu
    func openInAppleMaps(place: MKMapItem) {
        place.openInMaps(launchOptions: nil)
    }
}

#Preview {
    FavoritesView()
        .environmentObject(FavoritesManager())
}
