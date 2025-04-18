import SwiftUI

struct TagsView: View {
    @EnvironmentObject var noteNoteViewModel: NoteNoteViewModel
    
    var allTags: [String] {
        Array(Set(noteNoteViewModel.noteNotes.flatMap { $0.tags })).sorted()
    }
    
    var taggedNoteNotes: [String: [NoteNote]] {
        Dictionary(grouping: noteNoteViewModel.noteNotes) { noteNote in
            noteNote.tags.first ?? "Untagged"
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
                                TagSection(tag: tag, noteNotes: taggedNoteNotes[tag] ?? [])
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
            
            Text("Add tags to your noteNotes to organize them better")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

struct TagSection: View {
    let tag: String
    let noteNotes: [NoteNote]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(tag)
                .font(.headline)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.purple.opacity(0.2))
                .clipShape(Capsule())
            
            ForEach(noteNotes) { noteNote in
                TaggedNoteNoteRow(noteNote: noteNote)
            }
        }
    }
}

struct TaggedNoteNoteRow: View {
    let noteNote: NoteNote
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(noteNote.title)
                .font(.headline)
            
            Text(noteNote.content)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)
            
            if let reminder = noteNote.reminder {
                HStack {
                    Image(systemName: "bell.fill")
                        .foregroundStyle(.orange)
                    Text(reminder.formatted(.dateTime))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
    }
}