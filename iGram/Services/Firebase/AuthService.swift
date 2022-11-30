//
//  AuthService.swift
//  iGram
//
//  Created by Alexandr Kozin on 01.12.2022.
//

// Used to Authenticate users in Firebase
// Used to handle User accounts in Firebase

import Foundation
import FirebaseAuth
import UIKit
import FirebaseFirestore // Database

let DB_BASE = Firestore.firestore()

class AuthService {
    
    // MARK: PROPERTIES
    static let instance = AuthService()
    
    private var REF_USERS = DB_BASE.collection("users")
    
    // MARK: AUTH USER FUNCTIONS
    
    func logInUserToFirebase(credential: AuthCredential, handler: @escaping (_ providerID: String?, _ isError: Bool) -> ()) {
        
        Auth.auth().signIn(with: credential) { (result, error) in
            
            // Check for errors
            if error != nil {
                print("Error loggine in to Firebase")
                handler(nil, true)
                return
            }
            
            // Check for provider ID
            guard let providerID = result?.user.uid else {
                print("Error getting provider ID")
                handler(nil, true)
                return
            }
            
            // Success connecting to Firebase
            handler(providerID, false)
        }
        
    }
    
    func createNewUserInDatabase(name: String, email: String, providerID: String, provider: String, profileImage: UIImage, handler: @escaping(_ userID: String?) -> ()) {
        
        // Set up a user Document with the user Collection
        let document = REF_USERS.document()
        let userID = document.documentID
        
        // Upload profile to Storaga.
        ImageManager.instance.uploadProfileImage(userID: userID, image: profileImage)
        
        // Upload profile data to Firestore
        let userData: [String: Any] = [
            DatabaseUserField.displayName: name,
            DatabaseUserField.email: email,
            DatabaseUserField.providerID: providerID,
            DatabaseUserField.provider: provider,
            DatabaseUserField.userID: userID,
            DatabaseUserField.bio: "",
            DatabaseUserField.dateCreated: FieldValue.serverTimestamp(),
        ]
        
        document.setData(userData) { (error) in
            
            if let error = error {
                // ERROR
                print("Error uploading data to user document. \(error)")
                handler(nil)
            } else {
                // SUCCESS
                handler(userID)
            }
            
        }
        
    }
    
}
