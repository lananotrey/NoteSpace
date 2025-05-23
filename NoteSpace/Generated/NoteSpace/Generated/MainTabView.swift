import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var noteNoteViewModel: NoteNoteViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NotesView(selectedTab: $selectedTab)
                .environmentObject(noteNoteViewModel)
                .tabItem {
                    Label("Notes", systemImage: "note.text")
                }
                .tag(0)
            
            TagsView()
                .environmentObject(noteNoteViewModel)
                .tabItem {
                    Label("Tags", systemImage: "tag")
                }
                .tag(1)
            
            SettingsView()
                .environmentObject(noteNoteViewModel)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(2)
        }
        .tint(.purple)
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}