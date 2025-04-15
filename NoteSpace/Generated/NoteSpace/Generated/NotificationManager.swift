import UserNotifications

class NotificationManager {
    func scheduleNotification(for note: Note, at date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Note Reminder"
        content.body = note.title
        content.sound = .default
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: note.id.uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
    
    func removeNotification(for note: Note) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(
            withIdentifiers: [note.id.uuidString]
        )
    }
}