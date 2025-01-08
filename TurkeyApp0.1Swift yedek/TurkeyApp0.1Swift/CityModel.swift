import Foundation

struct City: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let image: String
    let population: String
    let description: String
    let latitude: String  // location'daki latitude'yı buraya alıyoruz
    let longitude: String // location'daki longitude'u buraya alıyoruz

    // Equatable için == operatörünü override ettik
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.id == rhs.id
    }
}
