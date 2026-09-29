import XCTest
@testable import ServiceBooking

final class ServicesViewModelTests: XCTestCase {
    private struct Stub: ServiceRepository {
        func services(query: String?, skip: Int, limit: Int) async throws -> ServicePage { .init(products: [.init(id: 1, title: "Repair", description: "", price: 49, thumbnail: nil)], total: 1, skip: 0, limit: 30) }
        func service(id: Int) async throws -> ServiceItem { fatalError() }
    }
    @MainActor func testLoadPublishesItems() async {
        let vm = ServicesViewModel(repository: Stub()); await vm.load()
        guard case .loaded(let items) = vm.state else { return XCTFail("Expected loaded state") }; XCTAssertEqual(items.count, 1)
    }
}
