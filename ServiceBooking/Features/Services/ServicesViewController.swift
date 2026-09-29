import UIKit

final class ServicesViewController: UITableViewController, UISearchResultsUpdating {
    private let viewModel: ServicesViewModel
    private var items: [ServiceItem] = []
    private var searchTask: Task<Void, Never>?
    var onSelect: ((ServiceItem) -> Void)?
    init(viewModel: ServicesViewModel) { self.viewModel = viewModel; super.init(style: .insetGrouped) }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override func viewDidLoad() {
        super.viewDidLoad(); title = "Services"; tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        let search = UISearchController(searchResultsController: nil); search.searchResultsUpdater = self; navigationItem.searchController = search
        refreshControl = UIRefreshControl(); refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        viewModel.onStateChange = { [weak self] state in self?.render(state) }; Task { await viewModel.load() }
    }
    @objc private func refresh() { Task { await viewModel.load(query: navigationItem.searchController?.searchBar.text) } }
    func updateSearchResults(for searchController: UISearchController) {
        searchTask?.cancel(); let text = searchController.searchBar.text ?? ""
        searchTask = Task { try? await Task.sleep(for: .milliseconds(300)); guard !Task.isCancelled else { return }; await viewModel.load(query: text) }
    }
    private func render(_ state: ServicesViewModel.State) {
        refreshControl?.endRefreshing()
        switch state {
        case .loaded(let value): items = value; tableView.backgroundView = nil; tableView.reloadData()
        case .failed(let message): let label = UILabel(); label.text = message; label.textAlignment = .center; label.numberOfLines = 0; tableView.backgroundView = label
        default: break
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { items.count }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]; let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration(); content.text = item.title; content.secondaryText = String(format: "$%.2f", item.price); cell.contentConfiguration = content; cell.accessoryType = .disclosureIndicator; return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { tableView.deselectRow(at: indexPath, animated: true); onSelect?(items[indexPath.row]) }
}
