import SwiftUI

struct PrivacyPolicyView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Group {
                        Text("Privacy Policy")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Last updated: \(Date.now.formatted(date: .long, time: .omitted))")
                            .foregroundStyle(.secondary)
                        
                        Text("Information Collection and Use")
                            .font(.headline)
                        
                        Text("We do not collect any personal information from our users. All notes and data are stored locally on your device.")
                        
                        Text("Data Storage")
                            .font(.headline)
                        
                        Text("All notes and settings are stored locally on your device. We do not have access to your notes or any other data you create within the app.")
                        
                        Text("Third-Party Services")
                            .font(.headline)
                        
                        Text("Our app does not use any third-party services that collect information about you.")
                        
                        Text("Changes to This Policy")
                            .font(.headline)
                        
                        Text("We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.")
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}