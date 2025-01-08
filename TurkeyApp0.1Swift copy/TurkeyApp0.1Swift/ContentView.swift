import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @ObservedObject var viewModel = CitysViewModel()
    @StateObject var searchViewModel = SearchViewModel()
    @StateObject var authManager = AuthManager()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                // Gradyan arka plan
                LinearGradient(
                    gradient: Gradient(colors: [.mor, .yesil]),
                    startPoint: .topTrailing,
                    endPoint: .bottomLeading
                )
                .ignoresSafeArea()

                VStack {
                    // Arama çubuğu
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                        TextField("SEARCH", text: $searchViewModel.searchTerm)
                            .foregroundColor(.white)
                            .textFieldStyle(PlainTextFieldStyle())
                    }
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)

                    if viewModel.isloading {
                        ProgressView("Yükleniyor...")
                    } else {
                        List {
                            ForEach(searchViewModel.filteredCities) { city in
                                NavigationLink(destination: CityDetailsView(city: city)) {
                                    CityRow(city: city)
                                }
                                .listRowBackground(Color.clear)
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .animation(.smooth, value: searchViewModel.searchTerm)
                    }
                }
            }
            .navigationTitle("İller Listesi")
            .navigationBarItems(trailing: 
                HStack {
                    NavigationLink(destination: FeedView()) {
                        Image(systemName: "photo.stack")
                            .foregroundColor(.white)
                    }
                    logoutButton
                }
            )
            .navigationBarItems(leading: HStack {
                favButton
                NavigationLink(destination:AIView()) {
                    Image(systemName: "sparkles")
                        .foregroundColor(.white)
                }
            })
            .onAppear {
                viewModel.fetchDutyCitys()
            }
            .onChange(of: viewModel.citys) { oldcities, newCities in
                withAnimation {
                    searchViewModel.setCities(newCities)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    var logoutButton: some View {
        Button(action: {
            logout()
        }) {
            Image(systemName: "person.crop.circle.badge.xmark")
                .foregroundColor(.white)
        }
        
    }
    var favButton: some View {
        NavigationLink(destination: FavoritesView()) {
            Image(systemName: "star.fill")
                .foregroundColor(.white)
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            authManager.isLoggedIn = false
            dismiss()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

struct CityRow: View {
    var city: City
    
    var body: some View {
        HStack {
            Text(city.name.uppercased())
                .font(.title2)
                .foregroundColor(.black)
                .padding(.leading)
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
                
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 500)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.regularMaterial)
        )
        .padding(.vertical, 5)
    }
}

#Preview {
    ContentView()
        .environmentObject(FavoritesManager())

}
