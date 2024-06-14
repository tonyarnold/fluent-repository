import Vapor

public actor RepositoryRegistry {
    init(_ app: Application) {
        self.app = app
        self.builders = [:]
    }

    public func register(_ id: RepositoryIdentifier, _ builder: @escaping (Request) -> Repository) {
        builders[id] = builder
    }

    func builder(_ req: Request) -> RepositoryFactory {
        .init(req, self)
    }

    func make(_ id: RepositoryIdentifier, _ req: Request) -> Repository {
        guard let builder = builders[id] else {
            fatalError("Repository with identifier `\(id.string)` is not configured.")
        }
        return builder(req)
    }

    private let app: Application
    private var builders: [RepositoryIdentifier: (Request) -> Repository]
}
