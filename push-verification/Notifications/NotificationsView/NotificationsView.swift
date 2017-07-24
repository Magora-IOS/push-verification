
import RxCocoa
import RxSwift
import UIKit

class NotificationsView: UIView {

    // MARK: PUBLIC

    //let deviceToken: Variable<String> = Variable("")

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupNotificationsView()
    }


    // MARK: PRIVATE
    
    @IBOutlet private var tableView: UITableView!

    private let disposeBag = DisposeBag()
    
    private func setupNotificationsView() {
        /*
        self.setupTitles()
        self.setupTopOffset()
        self.setupDeviceToken()
        */
    }

    /*
    private func setupDeviceToken() {
        self.deviceToken
            .asObservable()
            .bind(to: self.deviceTokenTextView.rx.text)
            .disposed(by: disposeBag)
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
    */
    
}

