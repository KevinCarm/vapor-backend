//
//  GroupModel.swift
//  VaporBackend
//
//  Created by Kevin Carmona Serrano on 10/10/26.
//

import Fluent
import Vapor

final class GroupModel: Model, Content, @unchecked Sendable {
    static let schema: String = "groups"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "GROUP_NAME")
    var groupName: String
    
    @Field(key: "DESCRIPTION")
    var description: String
    
    @Field(key: "IS_ACTIVE")
    var isActive: Bool
    
    init(id: UUID? = UUID(), groupName: String, description: String, isActive: Bool) {
        self.id = id
        self.groupName = groupName
        self.description = description
        self.isActive = isActive
    }
    
    init() {
        
    }
}
