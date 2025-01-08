//
//  ContentView.swift
//  ai_kalori_hesapla
//
//  Created by Furkan buğra karcı on 14.11.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MealInputView()
                .tabItem {
                    Label("Add Meal", systemImage: "camera.fill")
                }
            
            CalorieHistoryView()
                .tabItem {
                    Label("History", systemImage: "chart.bar.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
