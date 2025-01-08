import SwiftUI
import MapKit

struct Rview: View {
    var city: City // Şehir bilgisi
    
    @State private var region: MKCoordinateRegion
    @State private var places: [MKMapItem] = [] // Bulunan restoranlar listesi
    @State private var selectedPlace: MKMapItem? // Seçilen yerin bilgilerini tutacak değişken
    @EnvironmentObject var favoritesManager: FavoritesManager // Favori yöneticisi
    
    init(city: City) {
        self.city = city
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: Double(city.latitude)!, longitude: Double(city.longitude)!),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        ))
    }
    
    var body: some View {
        ZStack{
            LinearGradient(
                            gradient: Gradient(colors: [.mor, .yesil]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .ignoresSafeArea()
        VStack {
            // Harita Görünümü
            Map(coordinateRegion: $region, annotationItems: places) { place in
                MapAnnotation(coordinate: place.placemark.coordinate) {
                    Button(action: {
                        selectedPlace = place
                    }) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                            .font(.title)
                    }
                }
            }
            .frame(height: 400)
            .cornerRadius(10)
            .padding()
            .onAppear {
                searchForRestaurants()
            }
            
            // Seçilen Yer Bilgisi
            if let selectedPlace = selectedPlace {
                VStack(alignment: .leading) {
                    Text(selectedPlace.name ?? "Unknown Place")
                        .font(.headline)
                        .padding(.bottom, 5)
                    Text(selectedPlace.placemark.title ?? "No address available")
                        .font(.subheadline)
                    
                    // Apple Maps'te açmak için buton
                    HStack{
                        Button(action: {
                            openInAppleMaps(place: selectedPlace)
                        }) {
                            Text("Apple Maps'te Aç")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.linearGradient(colors: [.mor, .yesil],
                                                              startPoint: .topTrailing,
                                                              endPoint: .bottomTrailing))
                                )
                                .cornerRadius(8)
                        }
                        .padding(.top, 10)
                        
                        // Favorilere Ekle Butonu
                        Button(action: {
                            favoritesManager.addToFavorites(place: selectedPlace)
                        }) {
                            Text("Favorilere Ekle")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.linearGradient(colors: [.mor, .yesil],
                                                              startPoint: .topTrailing,
                                                              endPoint: .bottomTrailing))
                                )
                                .cornerRadius(8)
                        }
                        .padding(.top, 10)
                    }
                }
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
                .padding(.horizontal)
            } else {
                Text("Bir yer seçin")
                    .italic()
                    .padding()
            }
        }
        .navigationTitle("Restaurant")
    }
    }
    
    // Restoranları arayan fonksiyon
    func searchForRestaurants() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "restaurant" // Restoran araması yap
        request.region = region // Bölgeyi ayarla
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let response = response {
                self.places = response.mapItems // Bulunan restoranları güncelle
            } else if let error = error {
                print("Error searching for places: \(error.localizedDescription)")
            }
        }
    }
    
    // Apple Maps'te yeri açma fonksiyonu
    func openInAppleMaps(place: MKMapItem) {
        place.openInMaps(launchOptions: nil) // launchOptions yerine nil vererek aç
    }
}

#Preview {
    Rview(city: City(id: 1, name: "Izmir", image: "https://cdnp.flypgs.com/files/Sehirler-long-tail/izmir/izmir-gezilecek-yerler-saat-kulesi.jpg", population: "2000000", description: "Test Description", latitude: "27.1384", longitude: "38.4237"))
        .environmentObject(FavoritesManager()) // Favori yöneticisini unutmayın
}
