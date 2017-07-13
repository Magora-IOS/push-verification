
import RxSwift
import UIKit

class MainVC: UIViewController {

    let deviceToken: Variable<String> = Variable("")

    let disposeBag = DisposeBag()
    
    @IBOutlet var deviceTokenTextView: UITextView!
    
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
        // Bind the ugly way.
        self.deviceToken.asObservable()
            .subscribe(onNext: { token in
                self.deviceTokenTextView.text = token
                NSLog("MainVC. device token: '%@'", token)
            })
            .addDisposableTo(disposeBag)
    }
    
}

