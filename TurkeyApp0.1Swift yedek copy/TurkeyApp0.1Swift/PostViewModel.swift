import Foundation
import FirebaseAuth
import FirebaseDatabase
import UIKit

class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    private let db = Database.database().reference()
    
    func fetchPosts() {
        db.child("posts").queryOrdered(byChild: "timestamp").observe(.value) { snapshot, _ in
            guard let postsDict = snapshot.value as? [String: [String: Any]] else {
                print("Error fetching posts: Invalid data format")
                return
            }
            
            DispatchQueue.main.async {
                self.posts = postsDict.compactMap { id, data in
                    Post(id: id, data: data)
                }.sorted { post1, post2 in
                    // Sort by timestamp descending
                    return post1.timestamp > post2.timestamp
                }
            }
        }
    }
    
    func uploadPost(image: UIImage) {
        guard let userID = Auth.auth().currentUser?.uid else { 
            print("Error: No user logged in")
            return 
        }
        
        // Convert image to Base64
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            print("Error: Failed to convert image to data")
            return
        }
        
        let base64String = imageData.base64EncodedString()
        
        // Create post data
        let post: [String: Any] = [
            "userID": userID,
            "imageBase64": base64String,
            "timestamp": ServerValue.timestamp()
        ]
        
        // Generate a unique key for the post
        let postRef = db.child("posts").childByAutoId()
        
        // Save the post
        postRef.setValue(post) { error, _ in
            if let error = error {
                print("Error saving post: \(error.localizedDescription)")
            } else {
                print("Post successfully saved")
            }
        }
    }
} 
