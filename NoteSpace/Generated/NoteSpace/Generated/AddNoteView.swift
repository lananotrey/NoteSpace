import SwiftUI

struct AddNoteNoteView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var noteViewModel: NoteNoteViewModel
    @State private var title = ""
    @State private var content = ""
    @State private var tags = ""
    @State private var reminder: Date = Date()
    @State private var hasReminder = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("NoteNote Details")) {
                    TextField("Title", text: $title)
                    TextEditor(text: $content)
                        .frame(height: 150)
                    TextField("Tags (comma separated)", text: $tags)
                }
                
                Section(header: Text("Reminder")) {
                    Toggle("Set Reminder", isOn: $hasReminder)
                    
                    if hasReminder {
                        DatePicker("Reminder Time",
                                 selection: $reminder,
                                 in: Date()...)
                    }
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
        
        let note = NoteNote(
            title: title,
            content: content,
            tags: tagArray,
            reminder: hasReminder ? reminder : nil
        )
        
        noteViewModel.addNote(note)
        dismiss()
    }
}