import Vapor

public protocol Repository: Sendable {
    var request: Request { get }

    init(request: Request)
}
