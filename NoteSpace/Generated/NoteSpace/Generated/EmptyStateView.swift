import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "note.text")
                .font(.system(size: 60))
                .foregroundStyle(.purple.opacity(0.7))
            
            Text("No Notes Yet")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Start creating your notes by tapping the + button")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .font(.subheadline)
        }
    }
}