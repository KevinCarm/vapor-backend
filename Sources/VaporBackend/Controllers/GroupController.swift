//
//  GroupController.swift
//  VaporBackend
//
//  Created by Kevin Carmona Serrano on 10/10/26.
//

import Vapor
import Fluent

struct GroupController: RouteCollection {
    func boot(routes: any Vapor.RoutesBuilder) throws {
        let groupsController = routes.grouped("group")
        groupsController.post(use: createGroup)
    }
    
    /// Create a new group in the data base
    ///
    /// - Parameter req: Object with the group data
    /// - Returns: HTTP 201 Created.
    /// - Throws: `Abort.badRequest` if the group already exists.
    func createGroup(req: Request) async throws -> HTTPStatus {
        let group = try req.content.decode(GroupModel.self)
        
        //validate if group already exists
        if let _ = try await GroupModel.query(on: req.db)
            .filter(\.$groupName, .equal, group.groupName)
            .first()
        {
            throw Abort(.badRequest, reason: "Group alredy exists")
        }
        
        try? await group.save(on: req.db)
        return .created
    }
}
