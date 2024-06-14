import Foundation

public struct RepositoryIdentifier: Hashable, Codable, Sendable {
    public init(_ string: String) {
        self.string = string
    }

    public let string: String
}
