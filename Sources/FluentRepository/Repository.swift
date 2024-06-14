import Vapor

public protocol Repository: Sendable {
    init(_ request: Request)
}
