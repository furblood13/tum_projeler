import SwiftUI

struct CityDetailsView: View {
    var city: City

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.mor,.yesil]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading) {
                    // Şehir Fotoğrafı
                    AsyncImage(url: URL(string: city.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                    }
                    .padding()
                    
                    // Şehir Adı
                    Text("About \(city.name)")
                        .font(.largeTitle)
                        .bold()
                        .padding(.horizontal)
                    
                    // Şehir Açıklaması
                    Text(city.description)
                        .padding(.horizontal)
                    
                    // Butonlar
                    HStack(spacing: 10) {
                        NavigationLink(destination: TouristicPlacesView(city: city)) {
                            Text("Touristic Places")
                                .bold()
                                .font(.system(size: 13))
                                .frame(width: 110, height: 35)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.linearGradient(colors: [.mor, .yesil], 
                                              startPoint: .topTrailing, 
                                              endPoint: .bottomTrailing))
                                )
                                .foregroundColor(.white)
                        }
                        
                        NavigationLink(destination: Rview(city: city)) {
                            Text("Restaurant")
                                .bold()
                                .font(.system(size: 18))
                                .frame(width: 110, height: 35)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.linearGradient(colors: [.mor, .yesil],
                                              startPoint: .topTrailing,
                                              endPoint: .bottomTrailing))
                                )
                                .foregroundColor(.white)
                        }
                        
                        NavigationLink(destination: Hview(city: city)) {
                            Text("Hotels")
                                .bold()
                                .font(.system(size: 18))
                                .frame(width: 110, height: 35)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.linearGradient(colors: [.mor, .yesil],
                                              startPoint: .topTrailing,
                                              endPoint: .bottomTrailing))
                                )
                                .foregroundColor(.white)
                        }
                        
                    }
                    .padding()
                    
                    Spacer()
                }
                
                .navigationTitle(city.name)
                .onAppear(perform: {
                    print(city.image)
                })
            }
        }
    }
}

#Preview {
    CityDetailsView(city: City(id: 1, name: "Test City", image: "https://cdnp.flypgs.com/files/Sehirler-long-tail/izmir/izmir-gezilecek-yerler-saat-kulesi.jpg", population:"2000000", description: "Test Description", latitude: "0", longitude: "0"))
}
