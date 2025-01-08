import Foundation

struct City: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let photo: String
    let description: String
    let location: Location

    // Equatable için == operatörünü override ettik
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Location: Codable {
    let longitude: Double
    let latitude: Double
}
