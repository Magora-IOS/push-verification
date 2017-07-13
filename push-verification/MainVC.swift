
import UIKit

class MainVC: UIViewController {
    
    @IBOutlet var deviceTokenTextView: UITextView!
    
    var reactiveTest: ReactiveTest?

    // MARK: PUBLIC

    // TODO: Use reactive setup.
    func setDeviceToken(_ value: String) {
        self.deviceTokenTextView.text = value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    // MARK: PRIVATE

    func setup() {
        self.navigationItem.title = "Push verification"
        
        reactiveTest = ReactiveTest()
    }
}

