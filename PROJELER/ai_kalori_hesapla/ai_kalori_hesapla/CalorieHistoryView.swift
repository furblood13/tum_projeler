import SwiftUI

struct CalorieHistoryView: View {
    @State private var dailyCalories: [Date: Int] = [:]
    
    var body: some View {
        NavigationView {
            VStack {
                // Today's total
                HStack {
                    Text("Today's Total:")
                    Text("\(dailyCalories[Date()].map(String.init) ?? "0") calories")
                        .bold()
                }
                .font(.title2)
                .padding()
                
                // Weekly chart placeholder
                Text("Weekly Chart Coming Soon")
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .background(Color.gray.opacity(0.1))
                
                // Meal list
                List {
                    Text("Recent Meals Coming Soon")
                }
            }
            .navigationTitle("Calorie History")
        }
    }
} 