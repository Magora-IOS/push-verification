
import UIKit

class MainVC: UIViewController {
    
    @IBOutlet var deviceTokenTextField: UITextField!

    // MARK: PUBLIC

    func setDeviceToken(_ value: String) {
        self.deviceTokenTextField.text = value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

