import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    var title: String
    var content: String
    var tags: [String]
    var reminder: Date?
    var createdAt: Date
    
    init(id: UUID = UUID(), title: String, content: String, tags: [String], reminder: Date? = nil) {
        self.id = id
        self.title = title
        self.content = content
        self.tags = tags
        self.reminder = reminder
        self.createdAt = Date()
    }
}