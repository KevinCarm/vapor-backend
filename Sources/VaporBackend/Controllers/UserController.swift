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
        userController.get(":companyId", use: getUserById)
        userController.post(use: createUser)
    }
    
    /// Get an user by companyId
    ///
    /// - Parameter req: Object with the companyId param
    /// - Returns: HTTP 200 and the founded user
    /// - Throws: `Abort.badRequest` if the companyId does not exist.
    /// - Throws: `Abort.notFound` if the user is not found.
    func getUserById(req: Request) async throws -> UserWithOutPasswordDto {
        guard let companyId = req.parameters.get("companyId") else {
            throw Abort(.badRequest, reason: "companyId not provided")
        }
        
        guard let foundUser = try await UserModel.query(on: req.db)
            .filter(\.$companyId == companyId.uppercased()).first()
        else {
            throw Abort(.notFound, reason: "User not found with \(companyId)")
        }
        
        let returnUsers: UserWithOutPasswordDto = UserWithOutPasswordDto(
            companyId: foundUser.companyId,
            firstName: foundUser.firstName,
            lastName: foundUser.lastName,
            email: foundUser.email
        )
        
        return returnUsers
    }
    
    /// Create a new user in the data base
    ///
    /// - Parameter req: Object with the user data
    /// - Returns: HTTP 201 Created.
    /// - Throws: `Abort.badRequest` if the input json is invalid.
    func createUser(req: Request) async throws -> HTTPStatus {
        do {
            var user = try req.content.decode(UserDto.self)
            let encryptedPassword = try Bcrypt.hash(user.password)
            user.companyId = user.companyId.uppercased()
            let newUser: UserModel = UserModel(
                companyId: user.companyId,
                firstName: user.firstName,
                lastName: user.lastName,
                email: user.email,
                password: encryptedPassword
            )
            try await newUser.save(on: req.db)
        } catch {
            throw Abort(.badRequest, reason: "Json invalid")
        }
        
        return HTTPStatus.created
    }
}
