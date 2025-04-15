import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var noteViewModel: NoteViewModel
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NotesView()
                .tabItem {
                    Label("Notes", systemImage: "note.text")
                }
                .tag(0)
            
            TagsView()
                .tabItem {
                    Label("Tags", systemImage: "tag")
                }
                .tag(1)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(2)
        }
        .tint(.purple)
    }
}