import Foundation

@Observable
class SwingAnalysisViewModel {
    var selectedCategory: SwingCategory?
    let allIssues = SwingIssueData.all

    var filteredIssues: [SwingIssue] {
        if let category = selectedCategory {
            return allIssues.filter { $0.category == category }
        }
        return allIssues
    }

    func tips(for issue: SwingIssue) -> [Tip] {
        TipData.all.filter { issue.linkedTipIDs.contains($0.id) }
    }

    func drills(for issue: SwingIssue) -> [Drill] {
        DrillData.all.filter { issue.linkedDrillIDs.contains($0.id) }
    }

    func selectCategory(_ category: SwingCategory?) {
        if selectedCategory == category {
            selectedCategory = nil
        } else {
            selectedCategory = category
        }
    }
}
