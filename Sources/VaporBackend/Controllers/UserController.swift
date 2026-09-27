//
//  UserController.swift
//  VaporBackend
//
//  Created by Kevin Carmona Serrano on 26/09/26.
//

import Vapor
import Fluent

struct UserController: RouteCollection {
    func boot(routes: any Vapor.RoutesBuilder) throws {
        let userController = routes.grouped("users")
        userController.get(":id", use: getUserById)
    }
    
    func getUserById(req: Request) async throws -> UserModel {
        let id = req.parameters.get("id")
        let foundUser = try await UserModel.query(on: req.db)
            .filter(\.$name == id!)
            .first()
        return foundUser!
    }
}
