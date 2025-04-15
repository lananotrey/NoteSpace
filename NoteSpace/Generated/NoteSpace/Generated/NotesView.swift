import SwiftUI

struct NotesView: View {
    @EnvironmentObject var noteViewModel: NoteViewModel
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
                    if noteViewModel.filteredNotes.isEmpty {
                        EmptyStateView()
                    } else {
                        notesList
                    }
                }
            }
            .navigationTitle("Notes")
            .searchable(text: $searchText)
            .onChange(of: searchText) { _ in
                noteViewModel.filterNotes(searchText)
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
                AddNoteNoteView(noteViewModel: noteViewModel)
            }
        }
    }
    
    private var notesList: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(noteViewModel.filteredNotes) { note in
                    NoteNoteCard(note: note, noteViewModel: noteViewModel)
                        .transition(AnyTransition.scale)
                }
            }
            .padding()
        }
    }
}