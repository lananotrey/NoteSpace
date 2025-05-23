import SwiftUI

@MainActor
class NoteNoteViewModel: ObservableObject {
    @Published var noteNotes: [NoteNote] = []
    @Published var filteredNoteNotes: [NoteNote] = []
    
    init() {
        loadNoteNotes()
        filteredNoteNotes = noteNotes
    }
    
    func addNoteNote(_ note: NoteNote) {
        noteNotes.append(note)
        filteredNoteNotes = noteNotes
        saveNoteNotes()
    }
    
    func updateNoteNote(_ note: NoteNote) {
        if let index = noteNotes.firstIndex(where: { $0.id == note.id }) {
            noteNotes[index] = note
            filteredNoteNotes = noteNotes
            saveNoteNotes()
        }
    }
    
    func deleteNoteNote(_ note: NoteNote) {
        noteNotes.removeAll { $0.id == note.id }
        filteredNoteNotes = noteNotes
        saveNoteNotes()
    }
    
    func filterNoteNotes(_ searchText: String) {
        if searchText.isEmpty {
            filteredNoteNotes = noteNotes
        } else {
            filteredNoteNotes = noteNotes.filter { note in
                note.title.localizedCaseInsensitiveContains(searchText) ||
                note.content.localizedCaseInsensitiveContains(searchText) ||
                note.tags.contains { $0.localizedCaseInsensitiveContains(searchText) }
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