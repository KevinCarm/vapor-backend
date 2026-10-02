//
//  UserDto.swift
//  VaporBackend
//
//  Created by Kevin Carmona Serrano on 27/09/26.
//
import Vapor
import Fluent

struct UserDto: Content {
    var companyId: String
    var firstName: String
    var lastName: String
    var email: String?
    var password: String
    
    init(companyId: String, firstName: String, lastName: String, email: String? = nil, password: String) {
        self.companyId = companyId
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
    }
    
}
