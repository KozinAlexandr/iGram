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

class AuthService {
    
    // MARK: PROPERTIES
    static let instance = AuthService()
    
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
    
}
