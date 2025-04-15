import SwiftUI

struct TagsView: View {
    @EnvironmentObject var noteViewModel: NoteNoteViewModel
    
    var allTags: [String] {
        Array(Set(noteViewModel.notes.flatMap { $0.tags })).sorted()
    }
    
    var taggedNotes: [String: [NoteNote]] {
        Dictionary(grouping: noteViewModel.notes) { note in
            note.tags.first ?? "Untagged"
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.purple.opacity(0.3), .blue.opacity(0.2)],
                             startPoint: .topLeading,
                             endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                if allTags.isEmpty {
                    EmptyTagsView()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(allTags, id: \.self) { tag in
                                TagSection(tag: tag, notes: taggedNotes[tag] ?? [])
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Tags")
        }
    }
}

struct EmptyTagsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "tag")
                .font(.system(size: 70))
                .foregroundStyle(.purple.opacity(0.7))
            
            Text("No Tags Yet")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Add tags to your notes to organize them better")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

struct TagSection: View {
    let tag: String
    let notes: [NoteNote]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(tag)
                .font(.headline)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.purple.opacity(0.2))
                .clipShape(Capsule())
            
            ForEach(notes) { note in
                TaggedNoteRow(note: note)
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 4)
    }
}

struct TaggedNoteRow: View {
    let note: NoteNote
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(note.title)
                .font(.subheadline)
                .fontWeight(.medium)
            
            Text(note.content)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(2)
            
            if let reminder = note.reminder {
                HStack {
                    Image(systemName: "bell.fill")
                        .foregroundStyle(.orange)
                    Text(reminder