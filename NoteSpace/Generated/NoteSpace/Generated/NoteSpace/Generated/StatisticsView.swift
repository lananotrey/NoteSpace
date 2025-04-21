import SwiftUI

struct StatisticsView: View {
    let statistics: NoteStatistics
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section("Overview") {
                    StatisticRow(title: "Total Notes", value: statistics.totalNotes, icon: "note.text")
                    StatisticRow(title: "Total Tags", value: statistics.totalTags, icon: "tag")
                }
                
                Section("Time Period") {
                    StatisticRow(title: "Today", value: statistics.todayNotes, icon: "clock")
                    StatisticRow(title: "This Week", value: statistics.thisWeekNotes, icon: "calendar")
                    StatisticRow(title: "This Month", value: statistics.thisMonthNotes, icon: "calendar.badge.clock")
                }
            }
            .navigationTitle("Statistics")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct StatisticRow: View {
    let title: String
    let value: Int
    let icon: String
    
    var body: some View {
        HStack {
            Label(title, systemImage: icon)
            Spacer()
            Text("\(value)")
                .fontWeight(.semibold)
                .foregroundStyle(.purple)
        }
    }
}