import SwiftUI

struct NotesView: View {
    @EnvironmentObject var noteNoteViewModel: NoteNoteViewModel
    @State private var showingAddNote = false
    @State private var searchText = ""
    @State private var sortByDate = true
    @State private var showingStatistics = false
    @State private var selectedFilter: NoteFilter = .all
    
    private var filteredAndSortedNotes: [NoteNote] {
        let filtered = switch selectedFilter {
        case .all:
            noteNoteViewModel.filteredNoteNotes
        case .today:
            noteNoteViewModel.filteredNoteNotes.filter {
                Calendar.current.isDateInToday($0.createdAt)
            }
        case .thisWeek:
            noteNoteViewModel.filteredNoteNotes.filter {
                Calendar.current.isDate($0.createdAt, equalTo: Date(), toGranularity: .weekOfYear)
            }
        case .thisMonth:
            noteNoteViewModel.filteredNoteNotes.filter {
                Calendar.current.isDate($0.createdAt, equalTo: Date(), toGranularity: .month)
            }
        }
        
        return filtered.sorted { first, second in
            if sortByDate {
                return first.createdAt > second.createdAt
            } else {
                return first.title.lowercased() < second.title.lowercased()
            }
        }
    }
    
    var statistics: NoteStatistics {
        NoteStatistics(
            totalNotes: noteNoteViewModel.noteNotes.count,
            todayNotes: noteNoteViewModel.noteNotes.filter { Calendar.current.isDateInToday($0.createdAt) }.count,
            thisWeekNotes: noteNoteViewModel.noteNotes.filter { Calendar.current.isDate($0.createdAt, equalTo: Date(), toGranularity: .weekOfYear) }.count,
            thisMonthNotes: noteNoteViewModel.noteNotes.filter { Calendar.current.isDate($0.createdAt, equalTo: Date(), toGranularity: .month) }.count,
            totalTags: Set(noteNoteViewModel.noteNotes.flatMap { $0.tags }).count
        )
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.purple.opacity(0.3), .blue.opacity(0.2)],
                             startPoint: .topLeading,
                             endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack {
                    filterSegment
                    
                    if filteredAndSortedNotes.isEmpty {
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
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { showingStatistics = true }) {
                        Image(systemName: "chart.bar.fill")
                            .foregroundStyle(.purple)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Toggle(isOn: $sortByDate) {
                            Label("Sort by Date", systemImage: "calendar")
                        }
                        
                        Button(action: { showingAddNote = true }) {
                            Label("Add Note", systemImage: "plus")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.purple)
                    }
                }
            }
            .sheet(isPresented: $showingAddNote) {
                AddNoteNoteView(noteNoteViewModel: noteNoteViewModel)
            }
            .sheet(isPresented: $showingStatistics) {
                StatisticsView(statistics: statistics)
            }
        }
    }
    
    private var filterSegment: some View {
        Picker("Filter", selection: $selectedFilter) {
            ForEach(NoteFilter.allCases) { filter in
                Text(filter.title)
                    .tag(filter)
            }
        }
        .pickerStyle(.segmented)
        .padding()
    }
    
    private var notesList: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(filteredAndSortedNotes) { note in
                    NoteNoteCard(noteNote: note, noteNoteViewModel: noteNoteViewModel)
                        .transition(AnyTransition.opacity.combined(with: .scale))
                }
            }
            .padding()
            .animation(.easeInOut, value: filteredAndSortedNotes)
        }
    }
}