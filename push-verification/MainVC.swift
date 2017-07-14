
import SnapKit
import RxCocoa
import RxSwift
import UIKit

class MainVC: UIViewController {

    let deviceToken: Variable<String> = Variable("")

    private let disposeBag = DisposeBag()
    
    @IBOutlet private var topView: UIView!
    @IBOutlet private var deviceTokenTextView: UITextView!
    
    // MARK: PUBLIC

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    // MARK: PRIVATE

    private func setup() {
        self.navigationItem.title = "Push verification"
        self.setupTopOffset()
        self.setupDeviceToken()
    }

    private func setupDeviceToken() {
        self.deviceToken
            .asObservable()
            .bind(to: self.deviceTokenTextView.rx.text)
            .disposed(by: disposeBag)
    }

    private func setupTopOffset() {
        // Make sure topView's top is anchored to topLayoutGuide's bottom.
        self.topView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        }
    }
    
}

