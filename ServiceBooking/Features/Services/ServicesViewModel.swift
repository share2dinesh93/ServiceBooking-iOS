import Foundation

@MainActor
final class ServicesViewModel {
    enum State { case idle, loading, loaded([ServiceItem]), failed(String) }
    private let repository: ServiceRepository
    private(set) var state: State = .idle { didSet { onStateChange?(state) } }
    var onStateChange: ((State) -> Void)?
    init(repository: ServiceRepository) { self.repository = repository }
    func load(query: String? = nil) async {
        state = .loading
        do { state = .loaded(try await repository.services(query: query, skip: 0, limit: 30).products) }
        catch { state = .failed(error.localizedDescription) }
    }
}
