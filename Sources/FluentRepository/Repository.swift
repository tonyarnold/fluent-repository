import Vapor

public protocol Repository: Sendable {
    init(_ req: Request)
}
