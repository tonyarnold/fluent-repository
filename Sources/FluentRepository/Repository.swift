import FluentKit

public protocol Repository: Sendable {
    /// The database that this repository will interact with.
    var database: Database { get }

    init(database: Database)
}
