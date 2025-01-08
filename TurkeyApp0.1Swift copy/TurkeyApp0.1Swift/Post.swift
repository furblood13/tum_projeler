import Foundation
import UIKit
import FirebaseDatabase

struct Post: Identifiable {
    let id: String
    let userID: String
    let imageBase64: String
    let timestamp: Date
    let cityName: String
    let districtName: String
    let touristicPlaceName: String
    
    init(id: String, data: [String: Any]) {
        self.id = id
        self.userID = data["userID"] as? String ?? ""
        self.imageBase64 = data["imageBase64"] as? String ?? ""
        self.cityName = data["cityName"] as? String ?? ""
        self.districtName = data["districtName"] as? String ?? ""
        self.touristicPlaceName = data["touristicPlaceName"] as? String ?? ""
        
        if let timestamp = data["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp / 1000)
        } else {
            self.timestamp = Date()
        }
    }
    
    var image: UIImage? {
        guard let imageData = Data(base64Encoded: imageBase64) else { return nil }
        return UIImage(data: imageData)
    }
}
