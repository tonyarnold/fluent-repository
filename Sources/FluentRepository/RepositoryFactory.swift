import Vapor

public struct RepositoryFactory: Sendable {
    init(_ req: Request, _ registry: RepositoryRegistry) {
        self.req = req
        self.registry = registry
    }

    public func make(_ id: RepositoryIdentifier) async -> Repository {
        await registry.make(id, req)
    }

    private var registry: RepositoryRegistry
    private var req: Request
}
