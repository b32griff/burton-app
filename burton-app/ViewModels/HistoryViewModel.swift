import SwiftUI

@Observable
class HistoryViewModel {
    var searchText = ""

    func filteredConversations(from conversations: [Conversation]) -> [Conversation] {
        let sorted = conversations.sorted { $0.updatedAt > $1.updatedAt }

        if searchText.isEmpty {
            return sorted
        }

        return sorted.filter { conversation in
            conversation.title.localizedCaseInsensitiveContains(searchText)
            || (conversation.summary?.localizedCaseInsensitiveContains(searchText) ?? false)
            || conversation.messages.contains { $0.content.localizedCaseInsensitiveContains(searchText) }
        }
    }

    func groupedByDate(_ conversations: [Conversation]) -> [(String, [Conversation])] {
        let grouped = Dictionary(grouping: conversations) { conversation in
            conversation.updatedAt.relativeFormatted
        }

        // Order: Today, Yesterday, then by date
        let order = ["Today", "Yesterday"]
        return grouped.sorted { a, b in
            let aIndex = order.firstIndex(of: a.key) ?? Int.max
            let bIndex = order.firstIndex(of: b.key) ?? Int.max

            if aIndex != bIndex {
                return aIndex < bIndex
            }

            // Both are dates, sort by most recent
            let aDate = a.value.first?.updatedAt ?? .distantPast
            let bDate = b.value.first?.updatedAt ?? .distantPast
            return aDate > bDate
        }
    }
}
