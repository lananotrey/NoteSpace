import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "note.text")
                .font(.system(size: 70))
                .foregroundStyle(.purple.opacity(0.7))
            
            Text("No Notes Yet")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Start creating your notes by tapping the + button")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}