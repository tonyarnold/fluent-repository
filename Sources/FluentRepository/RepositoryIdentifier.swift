import Foundation

public struct RepositoryIdentifier: ExpressibleByStringLiteral, Hashable, Codable, Sendable {
    public init(_ string: String) {
        self.string = string
    }

    public init(stringLiteral: String) {
        self.string = stringLiteral
    }

    public let string: String
}
