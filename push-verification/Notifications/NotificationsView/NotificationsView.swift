
import UIKit

class NotificationsView: UIView {

    // MARK: - PUBLIC

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupNotificationsView()
    }

    // MARK: - PRIVATE

    @IBOutlet private var tableView: UITableView!
    
    private func setupNotificationsView() {
        NSLog("NotificationsView. setup")
    }

}

