import SwiftUI

struct AddNoteNoteView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var noteNoteViewModel: NoteNoteViewModel
    @State private var title = ""
    @State private var content = ""
    @State private var tags = ""
    @Binding var selectedTab: Int
    @State private var showSuccessAlert = false
    
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
        .alert("Success", isPresented: $showSuccessAlert) {
            Button("OK") {
                clearFields()
                selectedTab = 0
                dismiss()
            }
        } message: {
            Text("Note successfully added!")
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
        showSuccessAlert = true
    }
    
    private func clearFields() {
        title = ""
        content = ""
        tags = ""
    }
}