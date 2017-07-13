
import RxCocoa
import RxSwift
import UIKit

class MainVC: UIViewController {

    let deviceToken: Variable<String> = Variable("")

    private let disposeBag = DisposeBag()
    
    @IBOutlet private var deviceTokenTextView: UITextView!
    
    // MARK: PUBLIC

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    // MARK: PRIVATE

    private func setup() {
        self.navigationItem.title = "Push verification"
        self.setupDeviceToken()
    }

    private func setupDeviceToken() {
        self.deviceToken
            .asObservable()
            .bind(to: self.deviceTokenTextView.rx.text)
            .addDisposableTo(disposeBag)
    }
    
}

