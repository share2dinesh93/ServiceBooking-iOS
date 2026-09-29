import Foundation

final class RemoteServiceRepository: ServiceRepository {
    private let client: APIClientProtocol
    private let baseURL = URL(string: "https://dummyjson.com")!
    init(client: APIClientProtocol) { self.client = client }

    func services(query: String?, skip: Int, limit: Int) async throws -> ServicePage {
        let path = (query?.isEmpty == false) ? "products/search" : "products"
        var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)!
        var items = [URLQueryItem(name: "limit", value: String(limit)), URLQueryItem(name: "skip", value: String(skip))]
        if let query, !query.isEmpty { items.append(.init(name: "q", value: query)) }
        components.queryItems = items
        return try await client.get(components.url!, as: ServicePage.self)
    }

    func service(id: Int) async throws -> ServiceItem {
        try await client.get(baseURL.appendingPathComponent("products/\(id)"), as: ServiceItem.self)
    }
}
