
import CoreData
import RxSwift
import UIKit

// Backing store for notifications.

class NotificationsStore {

    enum Const {
        static let EntityName = "Notification"
        static let Payload = "payload"
        static let Date = "date"
    }

    //let lastError: Variable<NSError> = Variable(NSNull())

    private var context: NSManagedObjectContext
    
    init(_ context: NSManagedObjectContext) {
        self.context = context
    }

    func addNotification(_ notification: NotificationsItem) {
        let entity =
            NSEntityDescription.entity(
                forEntityName: Const.EntityName,
                in: self.context)
        let item = NSManagedObject(entity: entity!, insertInto: self.context)
        item.setValue(notification.payload, forKeyPath: Const.Payload)
        item.setValue(notification.date, forKeyPath: Const.Date)

        do {
            try context.save()
        }
        catch let error as NSError {
            NSLog("Could not save notification. ERROR: '\(error)' '\(error.userInfo)'");
            // TODO: update lastError
        }
    }

    func loadNotifications() -> [NotificationsItem] {
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: Const.EntityName)
        var notifications: [NotificationsItem] = []

        do {
            // Fetch core data items.
            let items = try self.context.fetch(fetchRequest)
            for item in items {
                // Convert to NotificationsItem.
                var notification = NotificationsItem()
                notification.date = item.value(forKey: Const.Date) as! Date
                notification.payload = item.value(forKey: Const.Payload) as! String
                // Append.
                notifications.append(notification)
            }
        }
        catch let error as NSError {
            NSLog("Could not load notifications. ERROR: '\(error)' '\(error.userInfo)'");
            // TODO: update lastError
        }

        return notifications
    }

}

