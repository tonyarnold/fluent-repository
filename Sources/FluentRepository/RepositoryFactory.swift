import Vapor

public struct RepositoryFactory: Sendable {
    init(
        request: Request,
        registry: RepositoryRegistry
    ) {
        self.request = request
        self.registry = registry
    }

    public func make(for id: RepositoryIdentifier) async -> Repository {
        await registry.makeRepository(for: id, request: request)
    }

    private var registry: RepositoryRegistry
    private var request: Request
}
