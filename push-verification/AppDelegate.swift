
import RxCocoa
import RxSwift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK PUBLIC

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.setupApplication()
        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()

        return true
    }

    // MARK PRIVATE

    private var notificationsVC: NotificationsVC!
    private var notifications: Notifications!
    
    private let disposeBag = DisposeBag()

    private func setupApplication() {
        // ViewModel.
        self.notifications = Notifications()

        // View.
        self.notificationsVC = NotificationsVC(nibName: "NotificationsVC", bundle: nil)
        let nvc = UINavigationController(rootViewController: self.notificationsVC)
        self.window!.rootViewController = nvc

        // Sync device token.
        self.notifications.deviceToken
            .asObservable()
            .bind(to: self.notificationsVC.deviceToken)
            .disposed(by: disposeBag)
    }

    // MARK NOTIFICATIONS
    
    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        self.notifications.application(
            application,
            didReceiveRemoteNotification: userInfo,
            fetchCompletionHandler: completionHandler)
    }
    func application(
        _ application: UIApplication,
        didRegister notificationSettings: UIUserNotificationSettings) {

        self.notifications.application(application, didRegister: notificationSettings)
    }
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        self.notifications.application(
            application,
            didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error) {

        self.notifications.application(
            application, 
            didFailToRegisterForRemoteNotificationsWithError: error)
    }

}

