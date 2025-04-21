import SwiftUI

@MainActor
class NoteViewModel: ObservableObject {
    @Published var notes: [NoteNote] = []
    @Published var filteredNotes: [NoteNote] = []
    private let notificationManager = NotificationManager()
    
    init() {
        loadNotes()
        filteredNotes = notes
    }
    
    func addNote(_ note: NoteNote) {
        notes.append(note)
        filteredNotes = notes
        saveNotes()
        
        if let reminder = note.reminder {
            notificationManager.scheduleNotification(for: note, at: reminder)
        }
    }
    
    func updateNote(_ note: NoteNote) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index] = note
            filteredNotes = notes
            saveNotes()
            
            notificationManager.removeNotification(for: note)
            if let reminder = note.reminder {
                notificationManager.scheduleNotification(for: note, at: reminder)
            }
        }
    }
    
    func deleteNote(_ note: NoteNote) {
        notes.removeAll { $0.id == note.id }
        filteredNotes = notes
        saveNotes()
        notificationManager.removeNotification(for: note)
    }
    
    func filterNotes(_ searchText: String) {
        if searchText.isEmpty {
            filteredNotes = notes
        } else {
            filteredNotes = notes.filter { note in
                note.title.localizedCaseInsensitiveContains(searchText) ||
                note.content.localizedCaseInsensitiveContains(searchText) ||
                note.tags.contains { $0.localizedCaseInsensitiveContains(searchText) }
            }
        }
    }
    
    private func saveNotes() {
        if let encoded = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encoded, forKey: "notes")
        }
    }
    
    private func loadNotes() {
        if let data = UserDefaults.standard.data(forKey: "notes"),
           let decoded = try? JSONDecoder().decode([NoteNote].self, from: data) {
            notes = decoded
        }
    }
}