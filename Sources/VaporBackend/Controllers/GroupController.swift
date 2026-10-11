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
        groupsController.post(":id", use: insertRoles)
    }
    
    /// Create a new group in the data base
    ///
    /// - Parameter req: Object with the group data
    /// - Returns: HTTP 201 Created.
    /// - Throws: `Abort.badRequest` if the group already exists.
    func createGroup(req: Request) async throws -> HTTPStatus {
        let group = try req.content.decode(GroupModel.self)
        
        //Validate if group already exists
        if let _ = try await GroupModel.query(on: req.db)
            .filter(\.$groupName, .equal, group.groupName)
            .first()
        {
            throw Abort(.badRequest, reason: "Group alredy exists")
        }
        
        try? await group.save(on: req.db)
        return .created
    }
    
    /// Insert a list of roles to a existing group
    ///
    /// - Parameter req: Object with the roles data
    /// - Returns: HTTP 201 Created.
    /// - Throws: `Abort.badRequest` if the group id is not provided.
    /// - Throws: `Abort.badRequest` if the group id is not a valid UUID.
    /// - Throws: `Abort.badRequest` if the json list is empty.
    /// - Throws: `Abort.badRequest` if the input is not a valid json.
    /// - Throws: `Abort.notFound` if the group is not found.
    func insertRoles(req: Request) async throws -> HTTPStatus {
        //Get the group id and parse it to UUID
        guard let groupId = req.parameters.get("id") else {
            throw Abort(.badRequest, reason: "Group id not provided")
        }
        guard let uuid = UUID(uuidString: groupId) else {
            throw Abort(.badRequest, reason: "The id: \(groupId) is not valid")
        }
        
        //Read and transform the input json
        var roleList: [RoleDTO]
        do {
            roleList = try req.content.decode([RoleDTO].self)
            if roleList.isEmpty {
                throw Abort(.badRequest, reason: "JSON input is empty")
            }
        } catch {
            throw Abort(.badRequest, reason: "Invalid JSON format")
        }
        
        //Transform the role list to a RoleModel
        let roleModelList: [RoleModel] = roleList.map { role in
            RoleModel(title: role.name)
        }
        try await roleModelList.create(on: req.db)
        
        //Insert the roles to the specific group
        guard let existGroup = try await GroupModel.find(uuid, on: req.db) else {
            throw Abort(.notFound, reason: "Group with id: \(groupId) not found")
        }
        
        try await existGroup.$roles.attach(roleModelList, on: req.db)
        return .created
    }
}
