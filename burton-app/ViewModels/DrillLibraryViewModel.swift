import Foundation

@Observable
class DrillLibraryViewModel {
    var selectedCategory: SwingCategory?
    let allDrills = DrillData.all

    var filteredDrills: [Drill] {
        if let category = selectedCategory {
            return allDrills.filter { $0.category == category }
        }
        return allDrills
    }

    var categories: [SwingCategory] {
        SwingCategory.allCases
    }

    func drills(for category: SwingCategory) -> [Drill] {
        allDrills.filter { $0.category == category }
    }

    func selectCategory(_ category: SwingCategory?) {
        if selectedCategory == category {
            selectedCategory = nil
        } else {
            selectedCategory = category
        }
    }
}
