//
//  PostModel.swift
//  iGram
//
//  Created by Alexandr Kozin on 20.11.2022.
//

import Foundation
import SwiftUI

struct PostModel: Identifiable, Hashable {
    
    var id = UUID()
    var postID: String // ID for the post in Database
    var userID: String // ID for the user in Database
    var username: String // Username of user in Database
    var caption: String?
    var dateCreated: Date
    var likeCount: Int
    var likedByUser: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
    // postID
    // userID
    // user username
    // caption - optional
    // date
    // like count
    // like by current user
}
