import SwiftUI
import PhotosUI

struct UploadView: View {
    @Environment(\.dismiss) var dismiss
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
                BackgroundView()
                
                ScrollView {
                    VStack(spacing: 20) {
                        ImageSelectionView(
                            selectedImage: $selectedImage,
                            selectedItem: $selectedItem
                        )
                        
                        InputFieldsView(
                            cityName: $cityName,
                            districtName: $districtName,
                            touristicPlaceName: $touristicPlaceName
                        )
                        
                        UploadButton(
                            canUpload: canUpload,
                            action: uploadPost
                        )
                    }
                    .padding()
                }
            }
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .overlay {
                if isUploading {
                    LoadingOverlay()
                }
            }
        }
    }
    
    private var canUpload: Bool {
        selectedImage != nil &&
        !cityName.isEmpty &&
        !districtName.isEmpty &&
        !touristicPlaceName.isEmpty
    }
    
    private func uploadPost() {
        guard let image = selectedImage else { return }
        
        isUploading = true
        postViewModel.uploadPost(
            image: image,
            cityName: cityName,
            districtName: districtName,
            touristicPlaceName: touristicPlaceName
        ) { success in
            isUploading = false
            if success {
                dismiss()
            }
        }
    }
}

// MARK: - Supporting Views
struct BackgroundView: View {
    var body: some View {
        LinearGradient(colors: [.mor, .yesil],
                      startPoint: .topTrailing,
                      endPoint: .bottomLeading)
            .ignoresSafeArea()
    }
}

struct ImageSelectionView: View {
    @Binding var selectedImage: UIImage?
    @Binding var selectedItem: PhotosPickerItem?
    
    var body: some View {
        if let image = selectedImage {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .cornerRadius(10)
        } else {
            PhotosPicker(selection: $selectedItem,
                        matching: .images) {
                VStack {
                    Image(systemName: "photo.badge.plus")
                        .font(.largeTitle)
                    Text("Select Photo")
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
            }
        }
        .onChange(of: selectedItem) { oldValue, newValue in
            Task {
                if let data = try? await newValue?.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    selectedImage = image
                }
            }
        }
    }
}

struct InputFieldsView: View {
    @Binding var cityName: String
    @Binding var districtName: String
    @Binding var touristicPlaceName: String
    
    var body: some View {
        VStack(spacing: 15) {
            TextField("City Name", text: $cityName)
                .textFieldStyle(CustomTextFieldStyle())
            
            TextField("District Name", text: $districtName)
                .textFieldStyle(CustomTextFieldStyle())
            
            TextField("Touristic Place Name", text: $touristicPlaceName)
                .textFieldStyle(CustomTextFieldStyle())
        }
    }
}

struct UploadButton: View {
    let canUpload: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Upload Post")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(canUpload ? Color.blue : Color.gray)
                .cornerRadius(10)
        }
        .disabled(!canUpload)
    }
}

struct LoadingOverlay: View {
    var body: some View {
        ProgressView("Uploading...")
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(10)
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .foregroundColor(.white)
    }
}
