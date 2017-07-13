
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainVC: MainVC?
    var notification: Notification!

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)

        self.notification = Notification()

        self.setupMainVC()
        
        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()

        return true
    }

    // MARK PRIVATE

    func setupMainVC() {
        self.mainVC = MainVC(nibName: "MainVC", bundle: nil)
        let nvc = UINavigationController(rootViewController: self.mainVC!)
        self.window!.rootViewController = nvc
    }

    // MARK NOTIFICATION
    
    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {

        self.notification.application(application, didReceiveRemoteNotification: userInfo)
    }
    func application(
        _ application: UIApplication,
        didRegister notificationSettings: UIUserNotificationSettings) {

        self.notification.application(application, didRegister: notificationSettings)
    }
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        self.notification.application(
            application,
            didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error) {

        self.notification.application(
            application, 
            didFailToRegisterForRemoteNotificationsWithError: error)
    }

}

