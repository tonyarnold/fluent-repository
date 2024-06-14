import FluentKit

/// Repositories provide a template for implementing cleaner, better separated code for interacting with your Fluent model types.
///
/// A repository is usually composed of a collection of methods for performing queries against a specific model.
public protocol Repository: Sendable {
    /// The database that this repository will query and interact with.
    var database: Database { get }
    
    /// Initialize a new repository.
    /// - Parameter database: The database that this repository will query and interact with.
    init(database: Database)
}
