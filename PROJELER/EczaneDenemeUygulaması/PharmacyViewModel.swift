import Foundation
import FirebaseRemoteConfig

class PharmacyViewModel: ObservableObject {
    @Published var pharmacies: [Pharmacy] = []
    @Published var isLoading = false
    @Published var city: String = ""
    @Published var district: String = ""
    @Published var showError = false
    @Published var error1: String = ""

    private var remoteConfig: RemoteConfig

    init() {
        self.remoteConfig = RemoteConfig.remoteConfig()
        setupRemoteConfig()
        fetchRemoteConfigValues()
    }

    // MARK: - Remote Config Ayarları
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

    // MARK: - Nöbetçi Eczaneleri Çekme
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
                    }
                } else {
                    print("API isteği başarısız oldu veya sonuçlar yok")
                    DispatchQueue.main.async {
                        self?.showError = true
                        self?.error1 = "Sunucu kaynaklı bir hatadan dolayı veriler çekilemedi, lütfen uygulamayı yeniden başlatınız."
                    }
                }
            } catch {
                print("Genel hata: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.showError = true
                    self?.error1 = "Bir hata oluştu, lütfen daha sonra tekrar deneyiniz."
                }
            }
        }.resume()
    }
}
