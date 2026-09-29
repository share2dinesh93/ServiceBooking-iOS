import Foundation

struct ServiceItem: Codable, Hashable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let thumbnail: URL?
}

struct ServicePage: Codable {
    let products: [ServiceItem]
    let total: Int
    let skip: Int
    let limit: Int
}
