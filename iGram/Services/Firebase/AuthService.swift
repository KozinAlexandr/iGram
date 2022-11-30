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
    
    func logInUserToApp(userID: String, hanlder: @escaping(_ success: Bool) -> ()) {
        
        // Get the users info
        getUserInfo(forUserID: userID) { (returnedName, returnedBio) in
            
            if let name = returnedName, let bio = returnedBio {
                // Success
                print("Success getting user info while logging in")
                hanlder(true)
                
                // Set the users info into our app
                
            } else {
                // Error
                print("Error getting user info while logging in")
                hanlder(false)
            }
            
        }
        
    }
    
    func createNewUserInDatabase(name: String, email: String, providerID: String, provider: String, profileImage: UIImage, handler: @escaping(_ userID: String?) -> ()) {
        
        // Set up a user Document with the user Collection
        let document = REF_USERS.document()
        let userID = document.documentID
        
        // Upload profile to Storage
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
    
    // MARK: GET USER FUNCTIONS
    
    func getUserInfo(forUserID userID: String, hanlder: @escaping(_ name: String?, _ bio: String?) -> ()) {
        
        REF_USERS.document(userID).getDocument { (documentSnapshot, error) in
            if let document = documentSnapshot,
               let name = document.get(DatabaseUserField.displayName) as? String,
               let bio = document.get(DatabaseUserField.bio) as? String {
                print("Success getting user info")
                hanlder(name, bio)
                return
            } else {
                print("Error getting user info")
                hanlder(nil, nil)
                return
            }
                
            
        }
        
    }
    
    
}
