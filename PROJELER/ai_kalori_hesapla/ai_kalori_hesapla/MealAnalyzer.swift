import Foundation
import GoogleGenerativeAI

class MealAnalyzer: ObservableObject {
    private let apiKey = "AIzaSyC5ylOsAj1TgwVZ4p-ZCC_F4zGiEhYrOBM"
    
    func analyzeMeal(image: Data, portionInfo: String) async throws -> String {
        let model = GenerativeModel(name: "gemini-pro-vision", apiKey: apiKey)
        
        // Convert Data to base64 encoded image part
        let base64Image = image.base64EncodedString()
        let imagePart = ImagePart(data: base64Image, mimeType: "image/jpeg")
        let textPart = TextPart(text: """
            Analyze this food image and estimate calories.
            Please respond with ONLY a number followed by the word 'calories'.
            Example response: "500 calories"
            Portion info: \(portionInfo)
            """)
        
        let response = try await model.generateContent(imagePart, textPart)
        
        guard let text = response.text else {
            print("AI Response was empty")
            return "Unable to estimate calories"
        }
        
        print("AI Response:", text) // Debug print to see the response
        
        // Extract calorie estimate from AI response
        let caloriePattern = "\\b\\d+\\s*(?:calories|kcal|cal)\\b"
        guard let regex = try? NSRegularExpression(pattern: caloriePattern, options: .caseInsensitive),
              let match = regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)),
              let range = Range(match.range, in: text) else {
            print("Could not extract calories from response")
            return "Unable to estimate calories"
        }
        
        return String(text[range])
    }
}
