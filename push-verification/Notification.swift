
import RxSwift

import UIKit

// This class only works on iOS 8-10
// TODO: Support iOS10+
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
        self.deviceToken.value = token
    }

    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error) {

        NSLog("Notification. Failed to register. ERROR: '%@'", error as NSError)
        self.deviceToken.value = NSLocalizedString("Token.Error", comment: "")
    }

    init() {
        // Register for push notifications.
        let pushSettings =
            UIUserNotificationSettings(
                types: [.alert, .sound],
                categories: nil)
        UIApplication.shared.registerUserNotificationSettings(pushSettings)
        // Default value.
        self.deviceToken.value = NSLocalizedString("Token.Wait", comment: "")
    }
}

