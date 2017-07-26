
import CoreData
import RxSwift
import UIKit

// This class only works on iOS 8-10
// TODO: Support iOS10+

class Notifications {

    // MARK PUBLIC

    let deviceToken: Variable<String> = Variable("")
    let notifications: Variable<[NotificationsItem]> = Variable([])

    init(_ context: NSManagedObjectContext) {
        // Register for push notifications.
        let pushSettings =
            UIUserNotificationSettings(types: [.alert, .sound], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(pushSettings)

        // Default value.
        self.deviceToken.value = tr(.NotificationsTokenWait)



        // Get previously saved entities.

        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Notification")

        do {
            var notifications = try context.fetch(fetchRequest)
            // TODO: Convert NSManagedObject to NotificationItem.
            for notification in notifications {
                NSLog("Notification: '\(notification)'")
            }
        } catch let error as NSError {
            NSLog("Could not load notifications. ERROR: '\(error)' '\(error.userInfo)'");
        }


        // Save new entity.

        let entity =
            NSEntityDescription.entity(
                forEntityName: "Notification",
                in: context)
        let notification = NSManagedObject(entity: entity!, insertInto: context)
        notification.setValue("sample payload {}", forKeyPath: "payload")
        notification.setValue(Date(), forKeyPath: "date")

        do {
            try context.save()
            // TODO: append item to internal representation.
        } catch let error as NSError {
            NSLog("Could not save notification. ERROR: '\(error)' '\(error.userInfo)'");
        }

    }
    
    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        NSLog("Notification. User info: '\(userInfo)'")

        var item = NotificationsItem()
        
        // TODO: Move prettification to Item
        
        let data = try! JSONSerialization.data(withJSONObject: userInfo, options: .prettyPrinted)
        let prettyPayload = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        item.payload =  prettyPayload! as String
        
        //item.payload = userInfo
        notifications.value.append(item)

        completionHandler(.newData)
    }

    func application(
        _ application: UIApplication,
        didRegister notificationSettings: UIUserNotificationSettings) {

        NSLog("Notification. Settings changed to '\(notificationSettings)'")
        
        // Register to receive push notifications.
        UIApplication.shared.registerForRemoteNotifications()
    }

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        // Convert device token to hexidecimal string.
        let tokenParts = deviceToken.map { String(format: "%02.2hhx", $0) }
        let token = tokenParts.joined()
        NSLog("Notification. Device token: '\(token)'")
        self.deviceToken.value = token
    }

    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error) {

        NSLog("Notification. Failed to register. ERROR: '\(error)'")
        self.deviceToken.value = tr(.NotificationsTokenError)
    }

}

