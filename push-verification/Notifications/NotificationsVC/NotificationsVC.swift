
import SnapKit
import RxCocoa
import RxSwift
import UIKit

class NotificationsVC: UIViewController {

    // MARK: PUBLIC

    let deviceToken: Variable<String> = Variable("")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    // MARK: PRIVATE

    @IBOutlet private var topView: UIView!
    @IBOutlet private var deviceTokenLabel: UILabel!
    @IBOutlet private var deviceTokenTextView: UITextView!
    @IBOutlet private var notificationsLabel: UILabel!

    private let disposeBag = DisposeBag()
    
    private func setup() {
        self.setupTitles()
        self.setupTopOffset()
        self.setupDeviceToken()
    }

    private func setupDeviceToken() {
        self.deviceToken
            .asObservable()
            .bind(to: self.deviceTokenTextView.rx.text)
            .disposed(by: disposeBag)
    }

    private func setupTitles() {
        self.navigationItem.title =
            NSLocalizedString("NotificationsVC.Title", comment: "")
        self.deviceTokenLabel.text =
            NSLocalizedString("NotificationsVC.Token.Title", comment: "")
        self.notificationsLabel.text =
            NSLocalizedString("NotificationsVC.Notifications.Title", comment: "")
    }

    private func setupTopOffset() {
        // Make sure topView's top is anchored to topLayoutGuide's bottom.
        self.topView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        }
    }
    
}

