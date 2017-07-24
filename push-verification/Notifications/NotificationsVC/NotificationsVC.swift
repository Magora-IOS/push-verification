
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
    
    //private var notificationsView: NotificationsView!
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
        // Create and embed NotificationsView.
        //let notificationsViewNib = UINib(nibName: Const.NotificationsView, bundle: nil)
        //let notificationsViewNib = Bundle.main.loadNibNamed(Const.NotificationsView, owner: NotificationsView, options: nil)
        //self.notificationsView = notificationsView.loadFromNib() as! NotificationsView
        /*let nib = UINib(nibName: "NotificationsView", bundle: nil)
        self.notificationsView = nib.instantiate(withOwner: nil, options: nil).first as! NotificationsView
        */
        /*
        let nv : NotificationsView? = Bundle.main.loadNibNamed("NotificationsView", owner: self, options: nil)?.first as? NotificationsView
        
        NSLog("NotificationsView: '%p'", nv ?? "nil")
        */
        /*
        self.notificationsView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.notificationsContainerView)
        }
 */
        /*
        // Make sure topView's top is anchored to topLayoutGuide's bottom.
        self.topView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        }
        */
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

