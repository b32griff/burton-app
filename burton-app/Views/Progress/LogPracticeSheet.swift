import SwiftUI

struct LogPracticeSheet: View {
    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss

    var prefilledDrill: Drill?

    @State private var selectedDrillID: String?
    @State private var customDrillName = ""
    @State private var durationMinutes = 15
    @State private var rating = 3
    @State private var notes = ""

    private let durationOptions = [5, 10, 15, 20, 30, 45, 60]

    var body: some View {
        Form {
            // Drill Selection
            Section("What did you practice?") {
                if prefilledDrill != nil {
                    Text(prefilledDrill!.name)
                        .font(.subheadline.weight(.medium))
                } else {
                    Picker("Drill", selection: $selectedDrillID) {
                        Text("Custom / General Practice").tag(nil as String?)
                        ForEach(DrillData.all) { drill in
                            Text(drill.name).tag(drill.id as String?)
                        }
                    }

                    if selectedDrillID == nil {
                        TextField("What did you work on?", text: $customDrillName)
                    }
                }
            }

            // Duration
            Section("Duration") {
                Picker("Duration", selection: $durationMinutes) {
                    ForEach(durationOptions, id: \.self) { minutes in
                        Text("\(minutes) minutes").tag(minutes)
                    }
                }
                .pickerStyle(.segmented)
            }

            // Rating
            Section("How did it go?") {
                HStack {
                    Text("Rating")
                    Spacer()
                    RatingStars(rating: $rating)
                }
            }

            // Notes
            Section("Notes (optional)") {
                TextField("Any observations or breakthroughs?", text: $notes, axis: .vertical)
                    .lineLimit(3...6)
            }
        }
        .navigationTitle("Log Practice")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") { savePractice() }
                    .font(.headline)
                    .disabled(!canSave)
            }
        }
        .onAppear {
            if let drill = prefilledDrill {
                selectedDrillID = drill.id
            }
        }
    }

    private var canSave: Bool {
        if prefilledDrill != nil { return true }
        if selectedDrillID != nil { return true }
        return !customDrillName.trimmingCharacters(in: .whitespaces).isEmpty
    }

    private var drillName: String {
        if let drill = prefilledDrill {
            return drill.name
        }
        if let drillID = selectedDrillID,
           let drill = DrillData.all.first(where: { $0.id == drillID }) {
            return drill.name
        }
        return customDrillName.trimmingCharacters(in: .whitespaces)
    }

    private func savePractice() {
        let entry = PracticeLogEntry(
            drillID: prefilledDrill?.id ?? selectedDrillID,
            drillName: drillName,
            durationMinutes: durationMinutes,
            rating: rating,
            notes: notes.trimmingCharacters(in: .whitespacesAndNewlines)
        )
        appState.addPracticeEntry(entry)
        dismiss()
    }
}
