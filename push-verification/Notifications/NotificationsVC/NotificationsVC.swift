
import SnapKit
import RxCocoa
import RxSwift
import UIKit

class NotificationsVC: UIViewController {

    // MARK: - PUBLIC

    let deviceToken: Variable<String> = Variable("")

    enum Const {
        static let NotificationsView = "NotificationsView"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNotificationsVC()
    }

    // MARK: - PRIVATE

    private let disposeBag = DisposeBag()

    @IBOutlet private var topView: UIView!
    @IBOutlet private var deviceTokenLabel: UILabel!
    @IBOutlet private var deviceTokenTextView: UITextView!
    @IBOutlet private var notificationsLabel: UILabel!
    
    private var notificationsView: NotificationsView!
    @IBOutlet private var notificationsContainerView: UIView!

    private func setupNotificationsVC() {
        self.setupTitles()
        self.setupTopOffset()
        self.setupDeviceToken()
        self.setupNotifications()
    }

    private func setupDeviceToken() {
        self.deviceToken
            .asObservable()
            .bind(to: self.deviceTokenTextView.rx.text)
            .disposed(by: disposeBag)
    }

    private func setupNotifications() {
        self.notificationsView = NotificationsView.loadFromNib()
        self.notificationsContainerView.embeddedView = self.notificationsView
    }

    private func setupTitles() {
        self.navigationItem.title = tr(.NotificationsVCTitle)
        self.deviceTokenLabel.text = tr(.NotificationsVCTokenTitle)
        self.notificationsLabel.text = tr(.NotificationsVCNotificationsTitle)
    }

    private func setupTopOffset() {
        // Make sure topView's top is anchored to topLayoutGuide's bottom.
        self.topView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        }
    }
    
}

