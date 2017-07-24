
import UIKit

public extension UIView {

    class func loadFromNib(nibName: String) -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        let objects = nib.instantiate(withOwner: nil, options: nil)
        return objects.first as? UIView
    }

}

