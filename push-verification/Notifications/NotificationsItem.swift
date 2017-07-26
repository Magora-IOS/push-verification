
import RxSwift
import UIKit

struct NotificationsItem : CustomStringConvertible {
    var date: Date = Date()
    var payload: String = ""

    var description: String {
        return
            "NotifiationsItem(date: '\(date)' " +
            "payload: '\(payload)')"
    }
}

