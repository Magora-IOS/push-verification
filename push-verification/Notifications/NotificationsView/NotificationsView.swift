
import RxSwift
import UIKit

class NotificationsView: UIView, UITableViewDataSource {

    // MARK: - PUBLIC

    let notifications: Variable<[NotificationsItem]> = Variable([])

    enum Const {
        static let NotificationsItemCell = "NotificationsItemCell"
        static let NotificationsItemCellEstimatedHeight : CGFloat = 60
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupNotificationsView()
    }

    // MARK: - PRIVATE

    private let disposeBag = DisposeBag()

    @IBOutlet private var tableView: UITableView!
    
    private func setupNotificationsView() {
        self.setupTableView()

        // Refresh table view when items change.
        self.notifications
            .asObservable()
            .subscribe(onNext: { [unowned self] _ in
                self.tableView.reloadData()
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
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight =
            Const.NotificationsItemCellEstimatedHeight

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

