import SwiftUI

struct NoteNoteCard: View {
    let noteNote: NoteNote
    @ObservedObject var noteNoteViewModel: NoteNoteViewModel
    @State private var showingEditSheet = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(noteNote.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(2)
                
                Spacer()
                
                Menu {
                    Button(action: { showingEditSheet = true }) {
                        Label("Edit", systemImage: "pencil")
                    }
                    
                    Button(role: .destructive, action: { noteNoteViewModel.deleteNoteNote(noteNote) }) {
                        Label("Delete", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle.fill")
                        .foregroundStyle(.purple)
                }
            }
            
            Text(noteNote.content)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(4)
            
            HStack {
                ForEach(noteNote.tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.purple.opacity(0.2))
                        .clipShape(Capsule())
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 4)
        .sheet(isPresented: $showingEditSheet) {
            EditNoteNoteView(noteNote: noteNote, noteNoteViewModel: noteNoteViewModel)
        }
    }
}