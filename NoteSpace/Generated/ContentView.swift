import SwiftUI

struct ContentView: View {
    @StateObject private var noteViewModel = NoteViewModel()
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    
    var body: some View {
        Group {
            if hasCompletedOnboarding {
                MainTabView()
                    .environmentObject(noteViewModel)
            } else {
                OnboardingView()
            }
        }
    }
}