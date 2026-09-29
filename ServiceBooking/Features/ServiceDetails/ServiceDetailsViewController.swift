import UIKit

final class ServiceDetailsViewController: UIViewController {
    private let item: ServiceItem; private let favorites: FavoritesStoreProtocol
    init(item: ServiceItem, favorites: FavoritesStoreProtocol) { self.item = item; self.favorites = favorites; super.init(nibName: nil, bundle: nil) }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override func viewDidLoad() {
        super.viewDidLoad(); view.backgroundColor = .systemBackground; title = item.title
        let title = UILabel(); title.font = .preferredFont(forTextStyle: .title2); title.numberOfLines = 0; title.text = item.title
        let body = UILabel(); body.numberOfLines = 0; body.text = item.description
        let price = UILabel(); price.font = .preferredFont(forTextStyle: .headline); price.text = String(format: "$%.2f", item.price)
        let button = UIButton(type: .system); button.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        [title, body, price, button].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        let stack = UIStackView(arrangedSubviews: [title, body, price, button]); stack.axis = .vertical; stack.spacing = 16; stack.translatesAutoresizingMaskIntoConstraints = false; view.addSubview(stack)
        NSLayoutConstraint.activate([stack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor), stack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor), stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24)])
        self.button = button; updateButton()
    }
    private weak var button: UIButton?
    @objc private func toggleFavorite() { favorites.toggle(item.id); updateButton() }
    private func updateButton() { button?.setTitle(favorites.contains(item.id) ? "Remove from Favorites" : "Add to Favorites", for: .normal) }
}
