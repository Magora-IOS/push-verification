
import CoreData
import RxCocoa
import RxSwift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - PUBLIC

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

    // MARK: - PRIVATE

    private var notificationsVC: NotificationsVC!
    private var notifications: Notifications!
    
    private let disposeBag = DisposeBag()

    private func setupApplication() {
        // ViewModel.
        self.notifications = Notifications(self.persistentContainer.viewContext)

        // View.
        self.notificationsVC = NotificationsVC(nibName: "NotificationsVC", bundle: nil)
        let nvc = UINavigationController(rootViewController: self.notificationsVC)
        self.window!.rootViewController = nvc

        // Sync device token.
        self.notifications.deviceToken
            .asObservable()
            .bind(to: self.notificationsVC.deviceToken)
            .disposed(by: self.disposeBag)

        // Sync notifications.
        self.notifications.notifications
            .asObservable()
            .bind(to: self.notificationsVC.notifications)
            .disposed(by: self.disposeBag)
    }

    // MARK: - NOTIFICATIONS
    
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

    // MARK: - CORE DATA

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    private lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "notifications")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.
                // You should not use this function in a shipping application, although it
                // may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or
                   data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private func saveContext() {
        let context = self.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.
                // You should not use this function in a shipping application,
                // although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

