import Foundation

protocol FavoritesStoreProtocol: AnyObject {
    func contains(_ id: Int) -> Bool
    func toggle(_ id: Int)
}

final class FavoritesStore: FavoritesStoreProtocol {
    private let defaults: UserDefaults
    private let key = "favorite.service.ids"
    init(defaults: UserDefaults = .standard) { self.defaults = defaults }
    private var ids: Set<Int> {
        get { Set(defaults.array(forKey: key) as? [Int] ?? []) }
        set { defaults.set(Array(newValue), forKey: key) }
    }
    func contains(_ id: Int) -> Bool { ids.contains(id) }
    func toggle(_ id: Int) { var value = ids; value.contains(id) ? value.remove(id) : value.insert(id); ids = value }
}
