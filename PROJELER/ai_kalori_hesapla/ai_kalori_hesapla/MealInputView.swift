import SwiftUI
import PhotosUI

struct MealInputView: View {
    @State private var selectedImage: UIImage?
    @State private var imageSelection: PhotosPickerItem?
    @State private var portionSize: String = ""
    @State private var additionalInfo: String = ""
    @State private var calorieEstimate: String = ""
    @StateObject private var mealAnalyzer = MealAnalyzer()
    @StateObject private var mealStore = MealStore()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Image Picker
                    PhotosPicker(selection: $imageSelection,
                               matching: .images) {
                        if let selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                        } else {
                            ContentUnavailableView("Tap to select a photo",
                                                 systemImage: "photo.badge.plus")
                        }
                    }
                    .onChange(of: imageSelection) {
                        Task {
                            if let data = try? await imageSelection?.loadTransferable(type: Data.self),
                               let image = UIImage(data: data) {
                                selectedImage = image
                                
                                // Call Gemini API
                                do {
                                    let portionInfo = "\(portionSize) \(additionalInfo)"
                                    calorieEstimate = try await mealAnalyzer.analyzeMeal(image: data, portionInfo: portionInfo)
                                } catch {
                                    calorieEstimate = "Error analyzing image"
                                }
                            }
                        }
                    }
                    
                    // User Input Fields
                    TextField("Portion Size", text: $portionSize)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("Additional Details", text: $additionalInfo)
                        .textFieldStyle(.roundedBorder)
                    
                    // AI Response
                    if !calorieEstimate.isEmpty {
                        Text("Estimated Calories: \(calorieEstimate)")
                            .font(.headline)
                    }
                    
                    Button("Save Meal") {
                        if let selectedImage,
                           let imageData = selectedImage.jpegData(compressionQuality: 0.8),
                           let calories = Int(calorieEstimate.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                            let meal = Meal(id: UUID(),
                                          date: Date(),
                                          calories: calories,
                                          imageData: imageData,
                                          notes: "\(portionSize) \(additionalInfo)")
                            mealStore.saveMeal(meal)
                            
                            // Reset form
                            self.selectedImage = nil
                            self.imageSelection = nil
                            self.portionSize = ""
                            self.additionalInfo = ""
                            self.calorieEstimate = ""
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(selectedImage == nil)
                }
                .padding()
            }
            .navigationTitle("Add Meal")
        }
    }
}