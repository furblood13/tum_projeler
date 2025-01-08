import Foundation
import UIKit
import FirebaseDatabase

struct Post: Identifiable {
    let id: String
    let userID: String
    let imageBase64: String
    let timestamp: Date
    
    // Initialize from Firebase Realtime Database
    init(id: String, data: [String: Any]) {
        self.id = id
        self.userID = data["userID"] as? String ?? ""
        self.imageBase64 = data["imageBase64"] as? String ?? ""
        
        // Convert timestamp to Date
        if let timestamp = data["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp / 1000) // Convert milliseconds to seconds
        } else {
            self.timestamp = Date()
        }
    }
    
    // Helper method to convert Base64 to UIImage
    var image: UIImage? {
        guard let imageData = Data(base64Encoded: imageBase64) else { return nil }
        return UIImage(data: imageData)
    }
}
