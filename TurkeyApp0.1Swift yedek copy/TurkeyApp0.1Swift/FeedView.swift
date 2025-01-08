import SwiftUI
import PhotosUI

struct FeedView: View {
    @StateObject private var postViewModel = PostViewModel()
    @State private var selectedItem: PhotosPickerItem?
    @State private var isUploading = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.mor, .yesil],
                             startPoint: .topTrailing,
                             endPoint: .bottomLeading)
                .ignoresSafeArea()
                
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(postViewModel.posts) { post in
                            PostView(post: post)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Feed")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    PhotosPicker(selection: $selectedItem,
                               matching: .images) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundStyle(.white)
                            .font(.title2)
                    }
                }
            }
            .onChange(of: selectedItem) { oldValue, newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        isUploading = true
                        await MainActor.run {
                            postViewModel.uploadPost(image: image)
                            isUploading = false
                            selectedItem = nil
                        }
                    }
                }
            }
            .overlay {
                if isUploading {
                    ProgressView("Uploading...")
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                }
            }
        }
        .onAppear {
            postViewModel.fetchPosts()
        }
    }
}

struct PostView: View {
    let post: Post
    
    var body: some View {
        VStack {
            if let image = post.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
            }
            
            HStack {
                Text("Posted by: \(post.userID)")
                    .font(.caption)
                    .foregroundStyle(.white)
                Spacer()
                Text(post.timestamp, style: .relative)
                    .font(.caption)
                    .foregroundStyle(.white)
            }
        }
        .padding(.horizontal)
        .background(.ultraThinMaterial)
        .cornerRadius(15)
    }
}

#Preview {
    FeedView()
} 
