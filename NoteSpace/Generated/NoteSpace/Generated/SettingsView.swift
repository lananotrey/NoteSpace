import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var showingResetAlert = false
    @State private var showingPrivacyPolicy = false
    @State private var showingTermsOfUse = false
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
                    
                    Section(header: Text("App")) {
                        Button(action: rateApp) {
                            HStack {
                                Label("Rate this app", systemImage: "star.fill")
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        
                        Button(action: shareApp) {
                            HStack {
                                Label("Share this app", systemImage: "square.and.arrow.up")
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    
                    Section(header: Text("Legal")) {
                        Button(action: { showingPrivacyPolicy = true }) {
                            HStack {
                                Label("Privacy Policy", systemImage: "lock.shield")
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        
                        Button(action: { showingTermsOfUse = true }) {
                            HStack {
                                Label("Terms of Use", systemImage: "doc.text")
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.secondary)
                            }
                        }
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
            .sheet(isPresented: $showingPrivacyPolicy) {
                PrivacyPolicyView()
            }
            .sheet(isPresented: $showingTermsOfUse) {
                TermsOfUseView()
            }
        }
    }
    
    private func resetAllNoteNotes() {
        noteNoteViewModel.noteNotes.forEach { noteNote in
            noteNoteViewModel.deleteNoteNote(noteNote)
        }
    }
    
    private func rateApp() {
        guard let appStoreURL = URL(string: "https://apps.apple.com/app/idYOUR_APP_ID") else { return }
        UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
    }
    
    private func shareApp() {
        guard let appStoreURL = URL(string: "https://apps.apple.com/app/idYOUR_APP_ID") else { return }
        let activityViewController = UIActivityViewController(
            activityItems: ["Check out this amazing note-taking app!", appStoreURL],
            applicationActivities: nil
        )
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootViewController = window.rootViewController {
            rootViewController.present(activityViewController, animated: true)
        }
    }
}