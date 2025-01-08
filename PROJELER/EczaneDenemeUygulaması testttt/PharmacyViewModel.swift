import Foundation
import CoreLocation
import SwiftUI
import FirebaseRemoteConfig

class PharmacyViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var pharmacies: [Pharmacy] = []
    @Published var isLoading = false
    @Published var city: String = ""
    @Published var district: String = ""
    @Published var showError = false
    @Published var error1: String = ""
    private let locationManager = CLLocationManager()
    @Published var userLocation: CLLocation?
    
    private var remoteConfig: RemoteConfig

    override init() {
        self.remoteConfig = RemoteConfig.remoteConfig()
        super.init()
        setupRemoteConfig()
        fetchRemoteConfigValues()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }

    private func setupRemoteConfig() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 3600 // 1 saat
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(["apikey1": "6CIZh3kL1r4qJuQ0QZNSTz:6CxCPkcatR54jrx8lxFKBJ" as NSObject])
    }
    
    private func fetchRemoteConfigValues() {
        remoteConfig.fetch { status, error in
            if let error = error {
                print("Remote Config fetch hatası: \(error.localizedDescription)")
            } else {
                print("Fetch durumu: \(status.rawValue)")
                self.remoteConfig.activate { _, _ in
                    let apiKey = self.remoteConfig["apikey1"].stringValue
                    print("Aktif API Anahtarı: \(apiKey)")
                }
            }
        }

    }

    private func getApiKey() -> String {
        return remoteConfig["apikey1"].stringValue
    }

    private func getDistance(to pharmacy: Pharmacy) -> Double {
        guard let userLocation = userLocation,
              let pharmacyLoc = pharmacy.loc else {
            return Double.infinity
        }

        let coordinate = PharmacyMapView.getCoordinate(from: pharmacyLoc)
        let pharmacyLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        return userLocation.distance(from: pharmacyLocation)
    }

    func calculateDistance(to pharmacy: Pharmacy) -> (text: String, color: Color) {
        guard let userLocation = userLocation,
              let pharmacyLoc = pharmacy.loc else {
            return ("Mesafe hesaplanamıyor(konum iznini aç)", .secondary)
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

        return (distanceText, color)
    }

    private func sortPharmaciesByDistance() {
        pharmacies.sort { (pharmacy1, pharmacy2) -> Bool in
            let distance1 = getDistance(to: pharmacy1)
            let distance2 = getDistance(to: pharmacy2)
            return distance1 < distance2
        }
    }

    func fetchDutyPharmacies() {
        isLoading = true
        let headers = [
            "content-type": "application/json",
            "authorization": "apikey \(getApiKey())"
        ]

        guard let url = URL(string: "https://api.collectapi.com/health/dutyPharmacy?ilce=\(district)&il=\(city)") else {
            print("Geçersiz URL")
            DispatchQueue.main.async {
                self.showError = true
            }
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        session.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
            }
            if let error = error {
                print("Hata: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.showError = true
                    self?.error1 = error.localizedDescription
                }
                return
            }

            guard let data = data else {
                print("Veri alınamadı")
                DispatchQueue.main.async {
                    self?.showError = true
                }
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(PharmacyResponse.self, from: data)
                if decodedResponse.success, let pharmacies = decodedResponse.result {
                    DispatchQueue.main.async {
                        self?.pharmacies = pharmacies
                        self?.sortPharmaciesByDistance()
                    }
                } else {
                    print("API isteği başarısız oldu veya sonuçlar yok")
                    DispatchQueue.main.async {
                        self?.showError = true
                        self?.error1 = "Sunucu kaynaklı bir hatadan dolayı veriler çekilemedi lütfen uygulamayı yeniden başlatınız"
                    }
                }
            } catch {
                print("Genel hata: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.showError = true
                }
            }
        }.resume()
    }
}

extension PharmacyViewModel {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            userLocation = location
            sortPharmaciesByDistance() // Konum güncellenince tekrar sıralama yap
        }
    }
}
