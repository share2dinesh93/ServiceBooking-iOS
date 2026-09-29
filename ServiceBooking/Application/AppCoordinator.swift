import UIKit

final class AppCoordinator {
    let navigationController: UINavigationController
    private let container: AppContainer
    init(navigationController: UINavigationController, container: AppContainer) { self.navigationController = navigationController; self.container = container }
    func start() {
        let vm = ServicesViewModel(repository: container.repository)
        let vc = ServicesViewController(viewModel: vm)
        vc.onSelect = { [weak self] item in self?.showDetails(item) }
        navigationController.setViewControllers([vc], animated: false)
    }
    private func showDetails(_ item: ServiceItem) {
        navigationController.pushViewController(ServiceDetailsViewController(item: item, favorites: container.favorites), animated: true)
    }
}
