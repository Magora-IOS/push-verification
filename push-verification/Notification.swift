
import RxSwift

import UIKit

class Notification {

    let deviceToken: Variable<String> = Variable("")

    // MARK PUBLIC
    
    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {

        NSLog("Notification. User info: '%@'", userInfo)
    }

    func application(
        _ application: UIApplication,
        didRegister notificationSettings: UIUserNotificationSettings) {

        NSLog("Notification. Settings changed to '%@'", notificationSettings)
        
        // Register to receive push notifications.
        UIApplication.shared.registerForRemoteNotifications()
    }

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        // Convert device token to hexidecimal string.
        let tokenParts = deviceToken.map { String(format: "%02.2hhx", $0) }
        let token = tokenParts.joined()
        NSLog("Notification. Device token: '%@'", token)
        // TODO
        //self.mainVC?.setDeviceToken(token)
    }

    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error) {

        NSLog("Notification. Failed to register. ERROR: '%@'", error as NSError)
        // TODO
        //self.mainVC?.setDeviceToken("ERROR getting device token")
    }

    init() {
        let pushSettings =
            UIUserNotificationSettings(
                types: [.alert, .sound],
                categories: nil)
        UIApplication.shared.registerUserNotificationSettings(pushSettings)
    }
}

