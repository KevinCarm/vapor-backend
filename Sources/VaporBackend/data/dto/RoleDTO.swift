//
//  RoleDTO.swift
//  VaporBackend
//
//  Created by Kevin Carmona Serrano on 10/10/26.
//

import Vapor

struct RoleDTO: Content {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
}
