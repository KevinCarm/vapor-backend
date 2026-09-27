//
//  UserWithOutPasswordDto.swift
//  VaporBackend
//
//  Created by Kevin Carmona Serrano on 27/09/26.
//

import Vapor

struct UserWithOutPasswordDto: Content {
    var companyId: String
    var firstName: String
    var lastName: String
    var email: String
    
    init(companyId: String, firstName: String, lastName: String, email: String) {
        self.companyId = companyId
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}
