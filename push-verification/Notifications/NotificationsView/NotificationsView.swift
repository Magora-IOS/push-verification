
import RxSwift
import UIKit

class NotificationsView: UIView, UITableViewDataSource, UITableViewDelegate {

    // MARK: - PUBLIC

    let notifications: Variable<[NotificationsItem]> = Variable([])

    enum Const {
        static let NotificationsItemCell = "NotificationsItemCell"
        static let NotificationsItemCellEstimatedHeight : CGFloat = 100
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupNotificationsView()
    }

    // MARK: - PRIVATE

    private let disposeBag = DisposeBag()

    @IBOutlet private var tableView: UITableView!

    private func scrollToBottom() {
        if (!self.notifications.value.isEmpty) {
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
            .map { return !$0.isEmpty }
            .subscribe(onNext: { [unowned self] _ in
                // Insert new item in the last row.
                let lastRow =
                    IndexPath(
                        row: self.notifications.value.count - 1,
                        section: 0)
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: [lastRow], with: .none)
                self.tableView.endUpdates()
                
                self.scrollToBottom()
                
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
        self.tableView.delegate = self
        
        self.setupTableViewCellHeight()
    }
    
    // MARK: - TABLE VIEW CELL HEIGHT
    
    private var cachedCellHeights = [IndexPath : CGFloat]()

    func setupTableViewCellHeight() {
        // Make cells self-sizing.
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func tableView(
        _ tableView: UITableView,
        estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {

        // Retrieve cell height if it has been visible at least once.
        if let height = self.cachedCellHeights[indexPath] {
            return height
        }
        // The first display uses automatic counting.
        else {
            return UITableViewAutomaticDimension
        }
    }

    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath) {

        // Cache cell height.
        self.cachedCellHeights[indexPath] = cell.frame.size.height
    }
        
    // MARK: - TABLE VIEW DELEGATE

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        
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

