import SwiftUI

struct NotesView: View {
    @EnvironmentObject var noteNoteViewModel: NoteNoteViewModel
    @State private var showingAddNote = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.purple.opacity(0.3), .blue.opacity(0.2)],
                             startPoint: .topLeading,
                             endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack {
                    if noteNoteViewModel.filteredNoteNotes.isEmpty {
                        EmptyStateView()
                    } else {
                        notesList
                    }
                }
            }
            .navigationTitle("Notes")
            .searchable(text: $searchText)
            .onChange(of: searchText) { _ in
                noteNoteViewModel.filterNoteNotes(searchText)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddNote = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.purple)
                    }
                }
            }
            .sheet(isPresented: $showingAddNote) {
                AddNoteNoteView(noteNoteViewModel: noteNoteViewModel)
            }
        }
    }
    
    private var notesList: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(noteNoteViewModel.filteredNoteNotes) { note in
                    NoteNoteCard(noteNote: note, noteNoteViewModel: noteNoteViewModel)
                        .transition(AnyTransition.opacity.combined(with: .scale))
                }
            }
            .padding()
            .animation(.easeInOut, value: noteNoteViewModel.filteredNoteNotes)
        }
    }
}