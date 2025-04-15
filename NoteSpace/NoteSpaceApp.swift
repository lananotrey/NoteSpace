import SwiftUI
import FirebaseCore
import FirebaseRemoteConfig

@main
struct NoteSpaceApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RemoteScreen()
        }
    }
}
