import SwiftUI
import PhotosUI

struct FeedView: View {
    @StateObject private var postViewModel = PostViewModel()
    @State private var showingUploadView = false
    
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
                    Button {
                        showingUploadView = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundStyle(.white)
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showingUploadView) {
                UploadPostView()
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
        VStack(alignment: .leading, spacing: 8) {
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
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(post.cityName), \(post.districtName)")
                    .font(.headline)
                    .foregroundStyle(.white)
                
                Text(post.touristicPlaceName)
                    .font(.subheadline)
                    .foregroundStyle(.white)
                
                HStack {
                    Text("Posted by: \(post.userEmail)")
                        .font(.caption)
                        .foregroundStyle(.white)
                    Spacer()
                    Text(post.timestamp, style: .relative)
                        .font(.caption)
                        .foregroundStyle(.white)
                }
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
        .background(.ultraThinMaterial)
        .cornerRadius(15)
    }
}

#Preview {
    FeedView()
} 
