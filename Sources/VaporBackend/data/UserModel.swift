//
//  UserModel.swift
//  VaporBackend
//
//  Created by Kevin Carmona Serrano on 26/09/26.
//

import Vapor
import Fluent

final class UserModel: Model, Content, @unchecked Sendable {
    
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
    
    init() {
        
    }
}
