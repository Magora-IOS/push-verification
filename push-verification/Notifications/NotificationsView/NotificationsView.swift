
import RxSwift
import UIKit

class NotificationsView: UIView, UITableViewDataSource {

    // MARK: - PUBLIC

    let notifications: Variable<[NotificationsItem]> = Variable([])

    enum Const {
        static let NotificationsItemCell = "NotificationsItemCell"
        //static let NotificationsItemCellEstimatedHeight : CGFloat = 60
        static let NotificationsItemCellEstimatedHeight : CGFloat = 160

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupNotificationsView()
    }

    // MARK: - PRIVATE

    private let disposeBag = DisposeBag()

    @IBOutlet private var tableView: UITableView!
    
    private func scrollToBottom() {
        if (self.notifications.value.count > 0) {
            let lastRow =
                IndexPath(
                    row: self.notifications.value.count - 1,
                    section: 0)
            self.tableView.scrollToRow(
                at: lastRow,
                at: .bottom,
                animated: true)
        }
    }

    private func setupNotificationsView() {
        self.setupTableView()

        // Refresh table view when items change.
        self.notifications
            .asObservable()
            .map { [unowned self] _ in
                return self.notifications.value.count > 0
            }
            .subscribe(onNext: { [unowned self] _ in
                //self.tableView.reloadData()
                
                let lastRow =
                    IndexPath(
                        row: self.notifications.value.count - 1,
                        section: 0)
                NSLog("latRow: '\(lastRow.row)'")
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: [lastRow], with: .none)
                self.tableView.endUpdates()
                
                //DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [unowned self] _ in
                   self.scrollToBottom()
                //})
                
            })
            .disposed(by: self.disposeBag)
    }

    private func setupTableView() {
        // Register cells.
        let cellNib = UINib(nibName: Const.NotificationsItemCell, bundle: nil)
        self.tableView.register(
            cellNib,
            forCellReuseIdentifier: Const.NotificationsItemCell)

        self.tableView.dataSource = self
        
        // Make sure cells are self-sizing.
        //self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.rowHeight = Const.NotificationsItemCellEstimatedHeight
        self.tableView.estimatedRowHeight =
            Const.NotificationsItemCellEstimatedHeight

    }

    // MARK: - TABLE VIEW DELEGATE

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        
        NSLog("numberOfRows: '\(self.notifications.value.count)'")
        return self.notifications.value.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        NSLog("cellForRow(\(indexPath.row))")

        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: Const.NotificationsItemCell,
                for: indexPath)
            as! NotificationsItemCell
        let item = self.notifications.value[indexPath.row]
        cell.date = item.date
        cell.payload = item.payload
        return cell
    }

}

