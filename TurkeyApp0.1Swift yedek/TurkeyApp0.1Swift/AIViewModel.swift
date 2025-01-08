//
//  fetchdata.swift
//  ai deneme
//
//  Created by Furkan buğra karcı on 14.11.2024.
//

import Foundation
import GoogleGenerativeAI
class AIViewModel: ObservableObject {
    @Published var fetchedText: String = ""
    
    func fetchData(prompt: String) async {
        print("fetchData fonksiyonu çalıştırılıyor...")
        let generativeModel = GenerativeModel(
            name: "gemini-1.5-flash",
            apiKey: APIKey.default
        )
        
        do {
            let response = try await generativeModel.generateContent(prompt)
            if let text = response.text {
                DispatchQueue.main.async {
                    self.fetchedText = text
                    print(text)
                }
            }
        } catch {
            print("Hata oluştu: \(error)")
        }
    }
}



