
import UIKit

class NotificationsView: UIView {

    // MARK: - PUBLIC

    class func instantiateFromNib() -> NotificationsView {
        let nib = UINib(nibName: "NotificationsView", bundle: nil)
        let arr = nib.instantiate(withOwner: self, options: nil)
        let view = arr.first
        return view as! NotificationsView
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupNotificationsView()
    }

    // MARK: - PRIVATE

    func setupNotificationsView() {
        NSLog("NotificationsView. setup")
    }

}

