//
//  RoleModel.swift
//  VaporBackend
//
//  Created by Kevin Carmona Serrano on 10/10/26.
//

import Vapor
import Fluent

final class RoleModel: Model, Content, @unchecked Sendable {
    static let schema = "ROLES"

        @ID(key: .id)
        var id: UUID?

        @Field(key: "TITLE")
        var title: String

        @Siblings(through: GroupsAndRolesModel.self, from: \.$role, to: \.$group)
        var groups: [GroupModel]
    
        init(title: String) {
            self.title = title
        }

        init() {}
}
