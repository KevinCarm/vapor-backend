//
//  GroupsAndRoles.swift
//  VaporBackend
//
//  Created by Kevin Carmona Serrano on 10/10/26.
//

import Vapor
import Fluent

final class GroupsAndRolesModel: Model, @unchecked Sendable, Content {
    static let schema = "GROUPS_AND_ROLES"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "GROUP_ID")
    var group: GroupModel
    
    @Parent(key: "ROLE_ID")
    var role: RoleModel
    
    init(id: UUID? = nil, group: GroupModel, role: RoleModel) {
        self.id = id
        self.group = group
        self.role = role
    }
    
    init() {
        
    }
}
