import FluentKit
import Vapor

public extension FluentKit.Model {
    static func require(_ id: Self.IDValue, on database: Database) async throws -> Self {
        guard let entity = try await Self.find(id, on: database) else {
            throw Abort(.notFound, reason: "\(Self.self) with id \(id) not found")
        }

        return entity
    }
}
