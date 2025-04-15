import UserNotifications

class NotificationManager {
    func scheduleNotification(for note: Note, at date: Date) {
        let content = UNMutableNotificationContent()
        content.title = note.title
        content.body = note.content
        content.sound = .default
        
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: note.id.uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func removeNotification(for note: Note) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(
            withIdentifiers: [note.id.uuidString]
        )
    }
}