import Foundation

protocol ServiceRepository {
    func services(query: String?, skip: Int, limit: Int) async throws -> ServicePage
    func service(id: Int) async throws -> ServiceItem
}
