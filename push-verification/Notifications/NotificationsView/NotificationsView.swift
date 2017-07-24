
import RxSwift
import UIKit

class NotificationsView: UIView, UITableViewDataSource {

    // MARK: - PUBLIC

    let items: Variable<[String]> = Variable([])

    enum Const {
        static let NotificationsCell = "NotificationsCell"
        static let NotificationsCellEstimatedHeight : CGFloat = 60
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
        self.items
            .asObservable()
            .subscribe(onNext: { [unowned self] items in
                self.tableView.reloadData()
            })
            .disposed(by: self.disposeBag)
    }

    private func setupTableView() {
        // Register cells.
        let cellNib = UINib(nibName: Const.NotificationsCell, bundle: nil)
        self.tableView.register(
            cellNib,
            forCellReuseIdentifier: Const.NotificationsCell)

        self.tableView.dataSource = self
        
        // Make sure cells are self-sizing.
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight =
            Const.NotificationsCellEstimatedHeight

    }

    // MARK: - TABLE VIEW DELEGATE

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {

        return self.items.value.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: Const.NotificationsCell,
                for: indexPath)
            as! NotificationsCell
        cell.title = self.items.value[indexPath.row]
        return cell
    }

}

