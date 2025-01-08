//
//  UploadPostView.swift
//  TurkeyApp0.1Swift
//
//  Created by Furkan buğra karcı on 29.12.2024.
//

import SwiftUI
import PhotosUI

struct UploadPostView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var postViewModel = PostViewModel()
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var cityName = ""
    @State private var districtName = ""
    @State private var touristicPlaceName = ""
    @State private var isUploading = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.mor, .yesil],
                             startPoint: .topTrailing,
                             endPoint: .bottomLeading)
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Image picker or selected image preview
                        if let selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .cornerRadius(10)
                        } else {
                            PhotosPicker(selection: $selectedItem,
                                       matching: .images) {
                                VStack {
                                    Image(systemName: "photo")
                                        .font(.largeTitle)
                                    Text("Select Photo")
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 200)
                                .background(.ultraThinMaterial)
                                .cornerRadius(10)
                            }
                        }
                        
                        // Input fields
                        VStack(spacing: 10) {
                            TextField("City Name", text: $cityName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            TextField("District Name", text: $districtName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            TextField("Touristic Place Name", text: $touristicPlaceName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            if selectedImage != nil {
                                Button("Upload") {
                                    uploadPost()
                                }
                                .buttonStyle(.borderedProminent)
                                .disabled(cityName.isEmpty || districtName.isEmpty || touristicPlaceName.isEmpty)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .onChange(of: selectedItem) { oldValue, newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        await MainActor.run {
                            selectedImage = image
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
    }
    
    private func uploadPost() {
        guard let image = selectedImage else { return }
        isUploading = true
        postViewModel.uploadPost(
            image: image,
            cityName: cityName,
            districtName: districtName,
            touristicPlaceName: touristicPlaceName
        )
        dismiss()
    }
}

#Preview {
    UploadPostView()
}
