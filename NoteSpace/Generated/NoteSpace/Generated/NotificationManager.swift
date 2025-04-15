import UserNotifications

class NotificationManager {
    func scheduleNotification(for noteNote: NoteNote, at date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "NoteNote Reminder"
        content.body = noteNote.title
        content.sound = .default
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: noteNote.id.uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
    
    func removeNotification(for noteNote: NoteNote) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(
            withIdentifiers: [noteNote.id.uuidString]
        )
    }
}