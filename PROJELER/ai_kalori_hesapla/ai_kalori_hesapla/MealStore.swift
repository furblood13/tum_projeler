import Foundation

struct Meal: Codable, Identifiable {
    let id: UUID
    let date: Date
    let calories: Int
    let imageData: Data
    let notes: String
}

class MealStore: ObservableObject {
    @Published private(set) var meals: [Meal] = []
    
    func saveMeal(_ meal: Meal) {
        meals.append(meal)
        // Implement persistence
    }
    
    func getDailyCalories(for date: Date) -> Int {
        // Calculate daily total
        return meals.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
            .reduce(0) { $0 + $1.calories }
    }
} 