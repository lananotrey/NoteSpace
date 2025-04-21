import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var currentPage = 0
    
    let pages = [
        OnboardingPage(
            image: "note.text",
            title: "Welcome to NoteSpace",
            description: "Create and organize your notes with ease. Add titles, content, and tags to keep your thoughts organized."
        ),
        OnboardingPage(
            image: "bell.badge",
            title: "Never Miss Important Notes",
            description: "Set reminders for your important notes and receive notifications at the right time."
        ),
        OnboardingPage(
            image: "tag.fill",
            title: "Smart Organization",
            description: "Use tags to categorize your notes and find them quickly with powerful search functionality."
        )
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.purple.opacity(0.3), .blue.opacity(0.2)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        OnboardingPageView(page: pages[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .animation(.easeInOut, value: currentPage)
                
                Button(action: {
                    if currentPage < pages.count - 1 {
                        withAnimation {
                            currentPage += 1
                        }
                    } else {
                        withAnimation {
                            hasCompletedOnboarding = true
                        }
                    }
                }) {
                    Text(currentPage == pages.count - 1 ? "Get Started" : "Next")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct OnboardingPage {
    let image: String
    let title: String
    let description: String
}

struct OnboardingPageView: View {
    let page: OnboardingPage
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: page.image)
                .font(.system(size: 100))
                .foregroundStyle(.purple)
                .scaleEffect(isAnimating ? 1.1 : 1.0)
                .animation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: isAnimating)
                .onAppear {
                    isAnimating = true
                }
            
            Text(page.title)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .transition(.slide)
            
            Text(page.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .padding(.horizontal)
                .transition(.scale)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}