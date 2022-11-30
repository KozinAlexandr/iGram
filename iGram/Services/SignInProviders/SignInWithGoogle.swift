//
//  SignInWithGoogle.swift
//  iGram
//
//  Created by Alexandr Kozin on 30.11.2022.
//

import Foundation
import SwiftUI
import GoogleSignIn
import FirebaseCore
import FirebaseAuth


class SignInWithGoogle {
    
    static let shared = SignInWithGoogle()
    var onboardingView: OnboardingView!
    
    private init() { }
  
    func signIn(view: OnboardingView) {
    
        self.onboardingView = view
    
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
    
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
    
        // Set is loading for an indicator
    
        GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewController()) { [self] user, error in
      
            if let error = error {
                print("ERROR SIGNING IN TO GOOGLE")
                //print(error.localizedDescription)
                self.onboardingView.showError.toggle()
                //self.onboardingView.errorMessage = error.localizedDescription
                return
            }
      
            guard let authentication = user?.authentication, let idToken = authentication.idToken
            else {
                return
            }
      
            guard let profile = user?.profile else { return }
      
            let fullName = profile.name
            let email = profile.email
      

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
      
            //print("SIGN IN TO FIREBASE NOW: name: \(fullName) and with email: \(email)")
            self.onboardingView.connectToFirebase(name: fullName, email: email, provider: "google", credential: credential)
    }
  }
  
  
    private func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .init() }
    
        guard let root = screen.windows.first?.rootViewController else { return .init() }
    
        return root
    }
}
