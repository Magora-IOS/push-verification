
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainVC: MainVC?


    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        setupMainVC()
        setupNotifications()
        
        window!.backgroundColor = UIColor.white
        window!.makeKeyAndVisible()

        return true
    }

    func application(
        _ application: UIApplication,
        didRegister notificationSettings: UIUserNotificationSettings) {

        NSLog("AppDelegate. Notification seetings changed to '%@'", notificationSettings)
    }
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        let tokens = deviceToken.map { String(format: "%02.2hhx", $0) }
        let token = tokens.joined()
        NSLog("AppDelegate. Device token: '%@'", token)
    }
    
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error) {

        NSLog("AppDelegate. Failed to register. ERROR: '%@'", error as NSError)
    }

    func setupMainVC() {
        mainVC = MainVC(nibName: "MainVC", bundle: nil)
        let nvc = UINavigationController(rootViewController: mainVC!)
        window!.rootViewController = nvc
    }

    func setupNotifications() {
        // iOS 8-10
        // Request permission to receive push notifications.
        let pushSettings = UIUserNotificationSettings(types: [.alert, .sound], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(pushSettings)
        // Register to receive push notifications.
        UIApplication.shared.registerForRemoteNotifications()

        // TODO: iOS10+
    }
}

