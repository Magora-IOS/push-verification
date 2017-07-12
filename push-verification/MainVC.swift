
import UIKit

class MainVC: UIViewController {
    
    @IBOutlet var deviceTokenTextView: UITextView!

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
    }
}

