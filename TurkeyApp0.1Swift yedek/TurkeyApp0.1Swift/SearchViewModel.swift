import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var searchTerm = "" {
        didSet {
            filterCities()
        }
    }
    @Published var filteredCities: [City] = []
    private var allCities: [City] = []

    func setCities(_ cities: [City]) {
        allCities = cities
        filterCities()
    }

    private func filterCities() {
        if searchTerm.isEmpty {
            filteredCities = allCities
        } else {
            filteredCities = allCities.filter { city in
                city.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
}
