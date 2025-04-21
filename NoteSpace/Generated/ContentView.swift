import SwiftUI

struct ContentView: View {
    @StateObject private var noteNoteViewModel = NoteNoteViewModel()
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        Group {
            if !hasCompletedOnboarding {
                OnboardingView()
            } else {
                MainTabView()
                    .environmentObject(noteNoteViewModel)
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}