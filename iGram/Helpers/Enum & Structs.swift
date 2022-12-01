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

struct DatabasePostField { // Fields with in Post Document in Database
    
    static let postID = "post_id"
    static let userID = "user_id"
    static let displayName = "display_name"
    static let caption = "caption"
    static let dateCreated = "date_created"
    static let likeCount = "like_count" // Int
    static let likedBy = "liked_by" // array
    static let comments = "comments" // sub-collection

}

struct DatabaseCommentsField { // Fields with in the Comment SUBcollection of a Post Document
    
    static let commentID = "comment_id"
    static let displayName = "display_name"
    static let userID = "user_id"
    static let content = "content"
    static let dateCreated = "date_created"

}

struct DatabaseReportsField { // Fields with in Report Document in Database
    
    static let content = "content"
    static let postID = "post_id"
    static let dateCreated = "date_created"
    
}

struct CurrentUserDefaults { // Fields for UserDefaults saved with in app
    
    static let displayName = "display_name"
    static let bio = "bio"
    static let userID = "user_id"
    
}


enum SettingsEditTextOption {
    case displayName
    case bio
}
