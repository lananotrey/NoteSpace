import Foundation

enum NoteFilter: String, CaseIterable, Identifiable {
    case all
    case today
    case thisWeek
    case thisMonth
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .all: return "All"
        case .today: return "Today"
        case .thisWeek: return "Week"
        case .thisMonth: return "Month"
        }
    }
}