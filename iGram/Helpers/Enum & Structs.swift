//
//  Enum & Structs.swift
//  iGram
//
//  Created by Alexandr Kozin on 01.12.2022.
//

import Foundation

struct DatabaseUserField { // Fields with in the User Document in Database
    
    static let displayName = "display_name"
    static let email = "email"
    static let providerID = "provider_id"
    static let provider = "provider"
    static let userID = "user_id"
    static let bio = "bio"
    static let dateCreated = "date_created"
    
}

struct CurrentUserDefaults { // Fields for UserDefaults saved with in app
    
    static let displayName = "display_name"
    static let bio = "bio"
    static let userID = "user_id"
    
}
