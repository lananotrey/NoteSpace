import SwiftUI

struct EditNoteNoteView: View {
    @Environment(\.dismiss) private var dismiss
    let noteNote: NoteNote
    @ObservedObject var noteNoteViewModel: NoteNoteViewModel
    
    @State private var title: String
    @State private var content: String
    @State private var tags: String
    @State private var reminder: Date
    @State private var hasReminder: Bool
    
    init(noteNote: NoteNote, noteNoteViewModel: NoteNoteViewModel) {
        self.noteNote = noteNote
        self.noteNoteViewModel = noteNoteViewModel
        _title = State(initialValue: noteNote.title)
        _content = State(initialValue: noteNote.content)
        _tags = State(initialValue: noteNote.tags.joined(separator: ", "))
        _reminder = State(initialValue: noteNote.reminder ?? Date())
        _hasReminder = State(initialValue: noteNote.reminder != nil)
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
                
                Section(header: Text("Reminder")) {
                    Toggle("Set Reminder", isOn: $hasReminder)
                    
                    if hasReminder {
                        DatePicker("Reminder Time",
                                 selection: $reminder,
                                 in: Date()...)
                    }
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
            tags: tagArray,
            reminder: hasReminder ? reminder : nil
        )
        
        noteNoteViewModel.updateNoteNote(updatedNoteNote)
        dismiss()
    }
}