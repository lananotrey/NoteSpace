import SwiftUI

struct EditNoteView: View {
    @Environment(\.dismiss) private var dismiss
    let note: NoteNote
    @ObservedObject var noteViewModel: NoteViewModel
    
    @State private var title: String
    @State private var content: String
    @State private var tags: String
    
    init(note: NoteNote, noteViewModel: NoteViewModel) {
        self.note = note
        self.noteViewModel = noteViewModel
        _title = State(initialValue: note.title)
        _content = State(initialValue: note.content)
        _tags = State(initialValue: note.tags.joined(separator: ", "))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Note Details")) {
                    TextField("Title", text: $title)
                    TextEditor(text: $content)
                        .frame(height: 150)
                    TextField("Tags (comma separated)", text: $tags)
                }
            }
            .navigationTitle("Edit Note")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveNote()
                    }
                    .disabled(title.isEmpty || content.isEmpty)
                }
            }
        }
    }
    
    private func saveNote() {
        let tagArray = tags
            .split(separator: ",")
            .map { String($0).trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
        
        let updatedNote = NoteNote(
            id: note.id,
            title: title,
            content: content,
            tags: tagArray
        )
        
        noteViewModel.updateNote(updatedNote)
        dismiss()
    }
}