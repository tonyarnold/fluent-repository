# Fluent Repository

Documentation is coming, please bear with me.


First define your repository protocol. ``ModelRepository`` defines a number of common methods that you'll need, but you can specify additional methods that conformances of this protocol need to implement.

```swift
protocol UserRepository: ModelRepository<User> {
    func find(email: String) async throws -> User?
    func upsert(email: String) async throws -> User
}
```

Second, define a concrete implementation of the protocol that your app can actually use:

```swift
struct DatabaseUserRepository: UserRepository {
    let database: Database

    func find(email: String) async throws -> User? {
        try await User.query(on: database)
            .filter(\.$email == email)
            .first()
    }

    func upsert(email: String) async throws -> User {
        let user = try await find(email: email) ?? User(email: email)
        user.email = email
        try await user.save(on: database)
        return user
    }
}
```

Down the track, you'll be able to define an in-memory implementation that you can use in your tests so that you're not hitting a real database during testing.

Now you'll need to setup an identifier for your repository, and extend ``RepositoryFactory`` to provide an easy way to access your repository.

```swift
extension RepositoryIdentifier {
    static let user = RepositoryIdentifier("user")
}

extension RepositoryFactory {
    var user: any UserRepository {
        get async {
            guard let result = await make(.user) as? (any UserRepository) else {
                fatalError("User repository is not configured")
            }
            return result
        }
    }
}
```

Finally, you'll need to register your repository during your application startup:

```swift
public func configure(_ app: Application) async throws {
    // …
    await app.repositories.register(.user) { request in
        DatabaseUserRepository(database: request.db)
    }
    // …
}
```

Now you can access your repository from within request handlers, like so:

```swift
func findUser(_ request: Request) async throws -> User? {
    return request.repositories.user.find(email: "bandit.heeler@thepound.dog.au")
}
```
