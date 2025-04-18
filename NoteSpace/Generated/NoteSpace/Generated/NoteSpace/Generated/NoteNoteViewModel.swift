import SwiftUI

@MainActor
class NoteNoteViewModel: ObservableObject {
    @Published var noteNotes: [NoteNote] = []
    @Published var filteredNoteNotes: [NoteNote] = []
    private let notificationManager = NotificationManager()
    
    init() {
        loadNoteNotes()
        filteredNoteNotes = noteNotes
    }
    
    func addNoteNote(_ noteNote: NoteNote) {
        noteNotes.append(noteNote)
        filteredNoteNotes = noteNotes
        saveNoteNotes()
        
        if let reminder = noteNote.reminder {
            notificationManager.scheduleNotification(for: noteNote, at: reminder)
        }
    }
    
    func updateNoteNote(_ noteNote: NoteNote) {
        if let index = noteNotes.firstIndex(where: { $0.id == noteNote.id }) {
            noteNotes[index] = noteNote
            filteredNoteNotes = noteNotes
            saveNoteNotes()
            
            notificationManager.removeNotification(for: noteNote)
            if let reminder = noteNote.reminder {
                notificationManager.scheduleNotification(for: noteNote, at: reminder)
            }
        }
    }
    
    func deleteNoteNote(_ noteNote: NoteNote) {
        noteNotes.removeAll { $0.id == noteNote.id }
        filteredNoteNotes = noteNotes
        saveNoteNotes()
        notificationManager.removeNotification(for: noteNote)
    }
    
    func filterNoteNotes(_ searchText: String) {
        if searchText.isEmpty {
            filteredNoteNotes = noteNotes
        } else {
            filteredNoteNotes = noteNotes.filter { noteNote in
                noteNote.title.localizedCaseInsensitiveContains(searchText) ||
                noteNote.content.localizedCaseInsensitiveContains(searchText) ||
                noteNote.tags.contains { $0.localizedCaseInsensitiveContains(searchText) }
            }
        }
    }
    
    private func saveNoteNotes() {
        if let encoded = try? JSONEncoder().encode(noteNotes) {
            UserDefaults.standard.set(encoded, forKey: "noteNotes")
        }
    }
    
    private func loadNoteNotes() {
        if let data = UserDefaults.standard.data(forKey: "noteNotes"),
           let decoded = try? JSONDecoder().decode([NoteNote].self, from: data) {
            noteNotes = decoded
        }
    }
}