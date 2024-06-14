import Vapor

public actor RepositoryRegistry {
    init(_ app: Application) {
        self.app = app
        self.builders = [:]
    }

    public func register(
        _ id: RepositoryIdentifier,
        _ builder: @Sendable @escaping (Request) -> Repository
    ) {
        builders[id] = builder
    }

    func builder(_ request: Request) -> RepositoryFactory {
        .init(request: request, registry: self)
    }

    func makeRepository(for id: RepositoryIdentifier, request: Request) -> Repository {
        guard let builder = builders[id] else {
            fatalError("Repository with identifier `\(id.string)` is not configured.")
        }
        return builder(request)
    }

    private let app: Application
    private var builders: [RepositoryIdentifier: (Request) -> Repository]
}
