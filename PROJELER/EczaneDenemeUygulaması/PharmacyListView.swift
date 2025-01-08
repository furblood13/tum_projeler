import SwiftUI
import CoreLocation
import MapKit

struct PharmacyListView: View {
    @ObservedObject var viewModel = PharmacyViewModel()
    @State private var userLocation: CLLocation? // Kullanıcının konumu
    private let locationManager = CLLocationManager()
    private var locationDelegate = LocationDelegate() // Delegate burada tutuluyor
    
    init(viewModel: PharmacyViewModel = PharmacyViewModel()) {
        self.viewModel = viewModel
    }
    
    var sortedPharmacies: [Pharmacy] {
        // Kullanıcı konumu varsa mesafeye göre sırala
        guard let userLocation = userLocation else {
            return viewModel.pharmacies
        }
        
        return viewModel.pharmacies.sorted { pharmacy1, pharmacy2 in
            let distance1 = calculateDistance(to: pharmacy1, userLocation: userLocation).distance
            let distance2 = calculateDistance(to: pharmacy2, userLocation: userLocation).distance
            return distance1 < distance2
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.darkred, Color.darkred]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack {
                    if viewModel.isLoading {
                        ProgressView("Yükleniyor...")
                    } else {
                        List(sortedPharmacies) { pharmacy in
                            Button(action: {
                                openInMaps(pharmacy: pharmacy)
                            }) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(pharmacy.name ?? "Bilinmiyor")
                                            .font(.headline)
                                            .foregroundStyle(.white)
                                        Text(pharmacy.address ?? "Adres Bilinmiyor")
                                            .font(.caption)
                                            .foregroundStyle(.white)
                                        Text("Tel: \(pharmacy.phone ?? "")")
                                            .font(.subheadline)
                                            .foregroundStyle(.white)
                                    }
                                    Spacer()
                                    VStack (alignment: .trailing){
                                        Spacer()
                                        let distance = calculateDistance(to: pharmacy, userLocation: userLocation)
                                        Text(distance.text)
                                            .foregroundColor(distance.color)
                                            .font(.caption)
                                    }
                                    VStack(alignment: .trailing) {
                                       
                                        Label("", systemImage: "location.square.fill")
                                            .foregroundStyle(.primary)
                                           
                                    }
                                }
                            }
                            .listRowBackground(LinearGradient(
                                colors: [.darkred, .ortaRed],
                                startPoint: .bottomLeading,
                                endPoint: .topTrailing
                            ))
                        }
                        .scrollContentBackground(.hidden)
                    }
                }
            }
            .navigationTitle("Nöbetçi Eczaneler")
            .onAppear {
                startLocationUpdates()
                viewModel.fetchDutyPharmacies()
            }
            .alert("Hata", isPresented: $viewModel.showError) {
                Button("Tamam", role: .cancel) {}
            } message: {
                Text(viewModel.error1)
            }
        }
    }

    // MARK: - Konum Başlatma
    private func startLocationUpdates() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationDelegate.onLocationUpdate = { location in
            self.userLocation = location
        }
        locationManager.delegate = locationDelegate
        locationManager.startUpdatingLocation()
    }

    // MARK: - Mesafe Hesaplama
    private func calculateDistance(to pharmacy: Pharmacy, userLocation: CLLocation?) -> (text: String, color: Color, distance: Double) {
        guard let userLocation = userLocation,
              let pharmacyLoc = pharmacy.loc else {
            return ("Konum hesaplanamıyor", .secondary, Double.greatestFiniteMagnitude)
        }

        let coordinate = PharmacyMapView.getCoordinate(from: pharmacyLoc)
        let pharmacyLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        let distanceInMeters = userLocation.distance(from: pharmacyLocation)
        let distanceText: String
        let color: Color

        if distanceInMeters < 1000 {
            distanceText = String(format: "%.0f m uzaklıkta", distanceInMeters)
            color = .green
        } else {
            let distanceInKm = distanceInMeters / 1000
            distanceText = String(format: "%.1f km uzaklıkta", distanceInKm)
            color = distanceInKm <= 2.0 ? .green : .secondary
        }

        return (distanceText, color, distanceInMeters)
    }

    // MARK: - Haritada Açma
    func openInMaps(pharmacy: Pharmacy) {
        let coordinate = PharmacyMapView.getCoordinate(from: pharmacy.loc)
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = pharmacy.name

        mapItem.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ])
    }
}

// MARK: - Konum Delegate'i
class LocationDelegate: NSObject, CLLocationManagerDelegate {
    var onLocationUpdate: ((CLLocation) -> Void)?

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            onLocationUpdate?(location)
        }
    }
}

#Preview {
    PharmacyListView()
}
