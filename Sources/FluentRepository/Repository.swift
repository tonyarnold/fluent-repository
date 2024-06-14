import FluentKit

public protocol Repository: Sendable {
    /// The database that this repository will query and interact with.
    var database: Database { get }
    
    /// Initialize a new repository.
    /// - Parameter database: The database that this repository will query and interact with.
    init(database: Database)
}
