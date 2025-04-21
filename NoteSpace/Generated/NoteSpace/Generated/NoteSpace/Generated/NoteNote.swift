import Foundation

struct NoteNote: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var content: String
    var tags: [String]
    var createdAt: Date
    
    init(id: UUID = UUID(), title: String, content: String, tags: [String]) {
        self.id = id
        self.title = title
        self.content = content
        self.tags = tags
        self.createdAt = Date()
    }
    
    static func == (lhs: NoteNote, rhs: NoteNote) -> Bool {
        lhs.id == rhs.id
    }
}