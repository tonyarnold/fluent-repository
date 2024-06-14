import Fluent
import Vapor

/// A repository that vends a Fluent model, and is backed by a database.
public protocol ModelRepository<FluentModel>: Repository {
    associatedtype FluentModel: Model

    /// A new, empty query builder for this repository's model type.
    func query() -> QueryBuilder<FluentModel>
}

public extension ModelRepository {
    /// A new, empty query builder for this repository's model type.
    func query() -> QueryBuilder<FluentModel> {
        FluentModel.query(on: database)
    }

    /// Saves the provided entity to the database.
    func save(_ entity: FluentModel) async throws {
        try await entity.save(on: database)
    }

    /// Creates and persists the provided entity to the database.
    func create(_ entity: FluentModel) async throws {
        try await entity.create(on: database)
    }

    /// Creates and persists a collection of new entities to the database.
    func create<C: Collection>(_ entities: C) async throws where C.Element == FluentModel {
        for entity in entities {
            try await entity.create(on: database)
        }
    }

    /// Deletes the entity with an identifier matching the provided identifier from the database.
    @discardableResult
    func delete(_ id: FluentModel.IDValue) async throws -> FluentModel {
        let entity = try await require(id)
        try await entity.delete(on: database)
        return entity
    }

    /// Deletes the entities with identifiers matching those provided from the database.
    func delete<ModelIdentifiers: Collection>(_ ids: ModelIdentifiers) async throws where ModelIdentifiers.Element == FluentModel.IDValue {
        try await query()
            .filter(\._$id ~~ ids)
            .delete()
    }

    /// Retrieves the entity with an identifier that matches the provided ``id`` parameter, and executes the provided ``update(…)``, before saving the entity to the database.
    @discardableResult
    func update(_ id: FluentModel.IDValue, update: @escaping (inout FluentModel) async throws -> Void) async throws -> FluentModel {
        var entity = try await require(id)
        try await update(&entity)
        try await entity.save(on: database)
        return entity
    }

    /// Looks up and returns the entity with an identifier matching the provided ``id`` parameter, and returns it if it exists.
    func find(_ id: FluentModel.IDValue) async throws -> FluentModel? {
        try await FluentModel.find(id, on: database)
    }

    /// Looks up and returns the entity with an identifier matching the provided ``id`` parameter. If the entity cannot be found, an ``Abort`` error is thrown with a response status of ``HTTPResponseStatus.notFound``.
    /// - throws: ``HTTPResponseStatus.notFound`` if an entity with a matching identifier cannot be found in the database.
    func require(_ id: FluentModel.IDValue) async throws -> FluentModel {
        try await FluentModel.require(id, on: database)
    }
}
