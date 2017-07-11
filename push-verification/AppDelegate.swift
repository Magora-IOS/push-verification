
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // iOS 8-10
        // Request permission to receive push notifications.
        let pushSettings = UIUserNotificationSettings(types: [.alert, .sound], categories: nil)
        application.registerUserNotificationSettings(pushSettings)
        // Register to receive push notifications.
        application.registerForRemoteNotifications()
        // TODO: iOS10+
        
        
        

        return true
    }

    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        NSLog("AppDelegate. Notification seetings changed to '%@'", notificationSettings)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokens = deviceToken.map { String(format: "%02.2hhx", $0) }
        let token = tokens.joined()
        NSLog("AppDelegate. Device token: '%@'", token)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        NSLog("AppDelegate. Failed to register. ERROR: '%@'", error as NSError)
    }
}

