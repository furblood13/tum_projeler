import SwiftUI
import GoogleMobileAds
struct IlilceView: View {
   
    @ObservedObject var PviewModel = PharmacyViewModel()
    @ObservedObject var loadCitys = LoadCitys()
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var shouldNavigate = false
    func currentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: Date())
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
                    Text("Bugün: \(currentDate())")
                        .padding()

                    Image("Image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 230)
                        .padding(.bottom, 30)
                        .fontWeight(.bold)

                    // İl Picker
                    Picker("İl seçin", selection: $loadCitys.selectedCity) {
                        ForEach(loadCitys.cities, id: \.self) { city in
                            Text(city.text).tag(city as City?) // Seçim için ilçe nesnesini kullan
                        }
                        
                    }
                    .pickerStyle(.menu)
                    .padding()
                    .background(Color.customblue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .accentColor(.white)
                    .onChange(of: loadCitys.selectedCity) {
                        PviewModel.city = loadCitys.selectedCity?.text ?? ""
                        if let districts = loadCitys.selectedCity?.districts, !districts.isEmpty {
                                loadCitys.selectedDistrict = districts.first
                                PviewModel.district = districts.first?.text ?? ""
                            } else {
                                loadCitys.selectedDistrict = nil
                                PviewModel.district = ""
                            }
                        }
                    .padding(20)
                    .frame(width: 250,height: 100)
                    // İlçe Picker
                    Picker("İlçe seçin", selection: $loadCitys.selectedDistrict) {
                        Text("Seçim Yapın").tag(nil as District?)
                           
                           
                        ForEach(loadCitys.districts, id: \.self) { district in
                            Text(district.text).tag(district as District?)
                        }
                        
                        
                    }
                    
                    .pickerStyle(.menu)
                    .padding()
                    .background(Color.customblue)
                    .cornerRadius(10)
                    .accentColor(.white)
                    .shadow(radius: 5)
                    .onChange(of: loadCitys.selectedDistrict) {
                        // Seçilen ilçeyi PviewModel.district'e ata
                        PviewModel.district = loadCitys.selectedDistrict?.text ?? "" // İlçenin ismini al ve at
                        
                    }
                    
                    // Eczaneleri getir butonu
                    Button(action: {
                        // İl ve ilçe seçimlerini kontrol et
                        if loadCitys.selectedCity?.text == "Lütfen il seçiniz" {
                            alertMessage = "Lütfen geçerli bir il ve ilçe seçiniz."
                            showAlert = true
                            
                        } else {
                            // Tüm şartlar sağlandığında gezinmeye izin ver
                            shouldNavigate = true
                            //showInterstitialAds()
                            
                        }
                        
                    }) {
                        Text("Eczaneleri Getir")
                            .padding()
                            .frame(width: 200, height: 50)
                            .background(Color.customblue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    .padding(30)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Hata"),
                            message: Text(alertMessage),
                            dismissButton: .default(Text("Tamam"))
                        )
                    }
                    NavigationLink(
                        destination: PharmacyListView(viewModel: PviewModel),
                        isActive: $shouldNavigate
                    ) {
                        EmptyView() // Görünmez NavigationLink
                    }
                    
                    .navigationTitle("Eczane Bul")
                    
                    Spacer()
                    AdBannerViewController(adUnitID: "ca-app-pub-9667377311847487/6493311688").frame(height: 50)
                    
                }
                
                    
                
                .foregroundStyle(Color.white)
                
            }
        }
    }
    
}

#Preview {
    IlilceView()
}

struct AdBannerViewController: UIViewControllerRepresentable {
    let adUnitID: String

    func makeUIViewController(context: Context) -> UIViewController {
        let bannerView = GADBannerView(adSize: GADAdSizeBanner) // Use a predefined ad size
        bannerView.adUnitID = adUnitID
        
        let viewController = UIViewController()
        viewController.view.addSubview(bannerView)
        
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bannerView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            bannerView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor)
        ])
        
        bannerView.load(GADRequest())
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
