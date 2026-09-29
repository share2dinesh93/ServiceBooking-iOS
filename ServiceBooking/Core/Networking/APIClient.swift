import Foundation

enum APIError: LocalizedError {
    case invalidResponse
    case statusCode(Int)
    case decoding(Error)

    var errorDescription: String? {
        switch self {
        case .invalidResponse: return "The server returned an invalid response."
        case .statusCode(let code): return "Request failed with HTTP status \(code)."
        case .decoding: return "The response could not be decoded."
        }
    }
}

protocol APIClientProtocol {
    func get<T: Decodable>(_ url: URL, as type: T.Type) async throws -> T
}

final class APIClient: APIClientProtocol {
    private let session: URLSession
    init(session: URLSession = .shared) { self.session = session }

    func get<T: Decodable>(_ url: URL, as type: T.Type) async throws -> T {
        let (data, response) = try await session.data(from: url)
        guard let http = response as? HTTPURLResponse else { throw APIError.invalidResponse }
        guard (200...299).contains(http.statusCode) else { throw APIError.statusCode(http.statusCode) }
        do { return try JSONDecoder().decode(T.self, from: data) }
        catch { throw APIError.decoding(error) }
    }
}
