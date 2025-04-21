import SwiftUI

struct AddNoteNoteView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var noteNoteViewModel: NoteNoteViewModel
    @State private var title = ""
    @State private var content = ""
    @State private var tags = ""
    
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
            .navigationTitle("New NoteNote")
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
        
        let noteNote = NoteNote(
            title: title,
            content: content,
            tags: tagArray
        )
        
        noteNoteViewModel.addNoteNote(noteNote)
        dismiss()
    }
}