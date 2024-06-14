import Vapor

public extension Request {
    var repositories: RepositoryFactory {
        get async {
            await application.repositories.builder(self)
        }
    }
}
