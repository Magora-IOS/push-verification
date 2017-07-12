
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainVC: MainVC?


    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)

        self.setupMainVC()
        self.setupNotifications()
        
        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()

        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        NSLog("AppDelegate. UserInfo: '%@'", userInfo)
    }

    func application(
        _ application: UIApplication,
        didRegister notificationSettings: UIUserNotificationSettings) {

        NSLog("AppDelegate. Notification seetings changed to '%@'", notificationSettings)
        
        // Register to receive push notifications.
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        // Convert device token to hexidecimal string.
        let tokens = deviceToken.map { String(format: "%02.2hhx", $0) }
        let token = tokens.joined()
        NSLog("AppDelegate. Device token: '%@'", token)
        self.mainVC?.setDeviceToken(token)
    }
    
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error) {

        NSLog("AppDelegate. Failed to register. ERROR: '%@'", error as NSError)
        self.mainVC?.setDeviceToken("ERROR getting device token")
    }

    func setupMainVC() {
        self.mainVC = MainVC(nibName: "MainVC", bundle: nil)
        let nvc = UINavigationController(rootViewController: self.mainVC!)
        self.window!.rootViewController = nvc
    }

    func setupNotifications() {
        // iOS 8-10
        // Request permission to receive push notifications.
        let pushSettings = UIUserNotificationSettings(types: [.alert, .sound], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(pushSettings)
        
        

        // TODO: iOS10+
    }
}

