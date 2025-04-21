import SwiftUI

struct EditNoteNoteView: View {
    @Environment(\.dismiss) private var dismiss
    let noteNote: NoteNote
    @ObservedObject var noteNoteViewModel: NoteNoteViewModel
    
    @State private var title: String
    @State private var content: String
    @State private var tags: String
    
    init(noteNote: NoteNote, noteNoteViewModel: NoteNoteViewModel) {
        self.noteNote = noteNote
        self.noteNoteViewModel = noteNoteViewModel
        _title = State(initialValue: noteNote.title)
        _content = State(initialValue: noteNote.content)
        _tags = State(initialValue: noteNote.tags.joined(separator: ", "))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("NoteNote Details")) {
                    TextField("Title", text: $title)
                    TextEditor(text: $content)
                        .frame(height: 150)
                    TextField("Tags (comma separated)", text: $tags)
                }
            }
            .navigationTitle("Edit NoteNote")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveNoteNote()
                    }
                    .disabled(title.isEmpty || content.isEmpty)
                }
            }
        }
    }
    
    private func saveNoteNote() {
        let tagArray = tags
            .split(separator: ",")
            .map { String($0).trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
        
        let updatedNoteNote = NoteNote(
            id: noteNote.id,
            title: title,
            content: content,
            tags: tagArray
        )
        
        noteNoteViewModel.updateNoteNote(updatedNoteNote)
        dismiss()
    }
}