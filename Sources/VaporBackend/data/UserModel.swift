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
    
    @Field(key: "COMPANY_ID")
    var companyId: String
    
    @Field(key: "FIRST_NAME")
    var firstName: String
    
    @Field(key: "LAST_NAME")
    var lastName: String
    
    @Field(key: "EMAIL")
    var email: String
    
    @Field(key: "PASSWORD")
    var password: String
    
    init(id: UUID? = UUID(), companyId: String, firstName: String, lastName: String, email: String, password: String) {
        self.id = id
        self.companyId = companyId
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
    }
    
    init() {
        
    }
}
