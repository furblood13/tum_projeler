import SwiftUI
import MapKit

struct PharmacyListView: View {
 
    @ObservedObject var viewModel = PharmacyViewModel()
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                // Gradyan arka plan
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
                        // List'i ZStack içinde sarmalıyoruz
                        ZStack {
                            // Arka planı burada tutmak için boş bir arka plan rengi ekliyoruz
                            Color.clear
                               
                                .ignoresSafeArea()

                            List(viewModel.pharmacies) { pharmacy in
                                Button(action: {
                                    openInMaps(pharmacy: pharmacy)
                                }) {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(pharmacy.name ?? "Bilinmiyor")
                                                .font(.headline)
                                                .foregroundStyle(.white)
                                            Text(pharmacy.dist ?? "Bilinmiyor")
                                                .font(.subheadline)
                                                .foregroundStyle(.white)

                                            Text(pharmacy.address ?? "Adres Bilinmiyor")
                                                .font(.caption)
                                                .foregroundStyle(.white)

                                            Text("tel no: \(pharmacy.phone!)")
                                                .font(.subheadline)
                                                .foregroundStyle(.white)

                                        }
                                      
                                        Spacer()
                                        VStack(alignment: .trailing) {
                                            Spacer()
                                            let distance = viewModel.calculateDistance(to: pharmacy)
                                            Text(distance.text)
                                                .foregroundColor(.customblue)
                                                .font(.caption)
                                                
                                        }
                                        
                                        VStack(alignment: .trailing) {
                                           
                                            Label("", systemImage: "location.square.fill")
                                                .foregroundStyle(.primary)
                                               
                                        }
                                        
                                    }
                                    
                                }
                                .listRowBackground(LinearGradient(colors: [.darkred,.ortaRed], startPoint: .bottomLeading, endPoint: .topTrailing))
                                
                            }
                            // List'in arka plan rengini temizliyoruz
                            .scrollContentBackground(.hidden)
                            
                        }
                    }
                }
            }
            .navigationTitle("Nöbetçi Eczaneler")
            
            .onAppear {
                viewModel.fetchDutyPharmacies()
            }
            .alert("Hata", isPresented: $viewModel.showError) {
                Button("Tamam", role: .cancel) {
                    Task{
                        
                    }
                }
            } message: {
                Text(viewModel.error1)
            }
        }
    }
    
    func openInMaps(pharmacy: Pharmacy) {
        let coordinate = PharmacyMapView.getCoordinate(from: pharmacy.loc)
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = pharmacy.name
        
        // Maps uygulamasını açma
        mapItem.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ])
    }
}

#Preview {
    PharmacyListView()
}



