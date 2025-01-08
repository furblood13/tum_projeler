import Foundation
import Combine

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    private var cancellables = Set<AnyCancellable>()
    
    func fetchProducts() {
        guard let url = URL(string: "https://fakestoreapi.com/products") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Product].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: \.products, on: self)
            .store(in: &cancellables)
    }
}
