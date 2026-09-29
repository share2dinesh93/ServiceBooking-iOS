import Foundation

final class AppContainer {
    let repository: ServiceRepository
    let favorites: FavoritesStoreProtocol
    init(repository: ServiceRepository = RemoteServiceRepository(client: APIClient()), favorites: FavoritesStoreProtocol = FavoritesStore()) {
        self.repository = repository; self.favorites = favorites
    }
}
