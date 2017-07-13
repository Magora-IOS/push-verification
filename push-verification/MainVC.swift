
import UIKit

class MainVC: UIViewController {
    
    @IBOutlet var deviceTokenTextView: UITextView!
    
    // MARK: PUBLIC

    // TODO: Use reactive setup.
    func setDeviceToken(_ value: String) {
        self.deviceTokenTextView?.text = value
        if (self.deviceTokenTextView != nil) {
            NSLog("MainVC. setDeviceToken for text view: '%@'", value)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    // MARK: PRIVATE

    private func setup() {
        self.navigationItem.title = "Push verification"
    }
}

