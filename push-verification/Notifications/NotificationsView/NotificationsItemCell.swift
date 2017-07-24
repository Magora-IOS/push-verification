
import UIKit

class NotificationsItemCell: UITableViewCell {

    // MARK: - OVERRIDE

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupNotificationsItemCell()
    }

    // MARK: - PROPERTY DATE
    
    var date: Date {
        get { return _date }
        set {
            _date = newValue
            self.updateDate()
        }
    }

    private var _date = Date()

    @IBOutlet private var dateLabel: UILabel!

    private func updateDate() {
        // Format date.
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        self.dateLabel?.text = dateFormatter.string(from: self.date)
    }

    // MARK: - PROPERTY PAYLOAD
    
    var payload: String {
        get { return _payload }
        set {
            _payload = newValue
            self.updatePayload()
        }
    }

    private var _payload = ""

    @IBOutlet private var payloadLabel: UILabel!

    private func updatePayload() {
        self.payloadLabel?.text = self.payload
    }

    // MARK: - THEME
    
    @IBOutlet private var shadowedView: UIView!
    @IBOutlet private var roundedView: UIView!

    private func setupTheme() {
        // Round corners.
        self.roundedView.layer.borderWidth = 0
        self.roundedView.layer.cornerRadius = 5
        self.roundedView.clipsToBounds = true
        // Shadow.
        self.shadowedView.layer.shadowColor = UIColor.black.cgColor
        self.shadowedView.layer.shadowRadius = 4
        self.shadowedView.layer.shadowOffset = CGSize(width: 0, height:3)
        self.shadowedView.layer.shadowOpacity = 0.2
    }

    // MARK: - PRIVATE

    private func setupNotificationsItemCell() {
        self.setupTheme()

        self.updateDate()
    }

}

