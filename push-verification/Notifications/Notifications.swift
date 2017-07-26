
import RxSwift
import UIKit

// This class only works on iOS 8-10
// TODO: Support iOS10+

class Notifications {

    let deviceToken: Variable<String> = Variable("")
    let notifications: Variable<[NotificationsItem]> = Variable([])

    init() {
        // Register for push notifications.
        let pushSettings =
            UIUserNotificationSettings(types: [.alert, .sound], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(pushSettings)

        // Default value.
        self.deviceToken.value = tr(.NotificationsTokenWait)
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

