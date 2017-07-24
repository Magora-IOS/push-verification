
import UIKit

public extension UIView {
    func loadFromNib() -> UIView? {
        return Bundle.main.loadNibNamed(String(describing: self), owner: self, options: nil)?.first as? UIView
    }
}

