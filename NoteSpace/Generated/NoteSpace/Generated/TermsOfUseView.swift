import SwiftUI

struct TermsOfUseView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Group {
                        Text("Terms of Use")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Last updated: \(Date.now.formatted(date: .long, time: .omitted))")
                            .foregroundStyle(.secondary)
                        
                        Text("Acceptance of Terms")
                            .font(.headline)
                        
                        Text("By accessing and using this application, you accept and agree to be bound by the terms and provision of this agreement.")
                        
                        Text("Use License")
                            .font(.headline)
                        
                        Text("Permission is granted to temporarily download one copy of the app for personal, non-commercial transitory viewing only.")
                        
                        Text("Restrictions")
                            .font(.headline)
                        
                        Text("You are specifically restricted from:\n• Publishing any app material in any other media\n• Selling, sublicensing and/or otherwise commercializing any app material\n• Publicly performing and/or showing any app material\n• Using this app in any way that is or may be damaging to this app\n• Using this app contrary to applicable laws and regulations")
                        
                        Text("Your Content")
                            .font(.headline)
                        
                        Text("You retain all rights to any content you create, post or store within the app. You are solely responsible for your content and any consequences of posting or publishing it.")
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