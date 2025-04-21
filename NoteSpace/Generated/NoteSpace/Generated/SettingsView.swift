import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("notificationEnabled") private var notificationEnabled = true
    @State private var showingResetAlert = false
    @EnvironmentObject var noteNoteViewModel: NoteNoteViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.purple.opacity(0.3), .blue.opacity(0.2)],
                             startPoint: .topLeading,
                             endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                Form {
                    Section(header: Text("Appearance")) {
                        Toggle("Dark Mode", isOn: $isDarkMode)
                    }
                    
                    Section(header: Text("Notifications")) {
                        Toggle("Enable Notifications", isOn: $notificationEnabled)
                    }
                    
                    Section(header: Text("Data Management")) {
                        Button(role: .destructive, action: { showingResetAlert = true }) {
                            Label("Reset All Notes", systemImage: "trash")
                        }
                    }
                    
                    Section(header: Text("About")) {
                        HStack {
                            Text("Version")
                            Spacer()
                            Text("1.0.0")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Settings")
            .alert("Reset All Notes", isPresented: $showingResetAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Reset", role: .destructive) {
                    resetAllNoteNotes()
                }
            } message: {
                Text("This action cannot be undone. Are you sure you want to delete all notes?")
            }
        }
    }
    
    private func resetAllNoteNotes() {
        noteNoteViewModel.noteNotes.forEach { noteNote in
            noteNoteViewModel.deleteNoteNote(noteNote)
        }
    }
}