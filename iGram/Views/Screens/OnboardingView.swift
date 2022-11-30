//
//  OnboardingView.swift
//  iGram
//
//  Created by Alexandr Kozin on 29.11.2022.
//

import SwiftUI
import FirebaseAuth

struct OnboardingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var showOnboardingPart2: Bool = false
    @State var showError: Bool = false
    
    var body: some View {
        VStack(spacing: 10) {
            
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
                .shadow(radius: 12)
            
            Text("Welcome to iGram!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.MyTheme.purpleColor)
            
            Text("iGram is the #1 app for posting pictures of your (who?) and sharing them across the world. We are a (who?)-loving community and we're happy to have you!")
                .font(.headline)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.MyTheme.purpleColor)
                .padding()
            
            // MARK: SIGN IN WITH APPLE
            // doesn't work because there is no Apple subscription
            Button(action: {
                showOnboardingPart2.toggle()
                //SignInWithApple.instance.startSignInWithAppleFlow(view: self)
            }, label: {
                SignInWithAppleButtonCustom()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
            })
            
            // MARK: SIGN IN WITH GOOGLE
            // maybe change "globe" to "google" icon
            Button(action: {
                SignInWithGoogle.shared.signIn(view: self)
                //showOnboardingPart2.toggle()
            }, label: {
                HStack {
                    
                    Image(systemName: "globe")
                    
                    Text("Sign in with Google")
                    
                }
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color(.sRGB, red: 222/255, green: 82/255, blue: 70/255, opacity: 1.0))
                .cornerRadius(6)
                .font(.system(size: 23, weight: .medium, design: .default))
            })
            .accentColor(Color.white)
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Continue as guest".uppercased())
                    .font(.headline)
                    .fontWeight(.medium)
                    .padding()
            })
            .accentColor(.black)
            
        }
        .padding(.all, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.MyTheme.beigeColor)
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $showOnboardingPart2, content: {
            OnboardingViewPart2()
        })
        .alert(isPresented: $showError, content: {
            return Alert(title: Text("Error signing in 😔"))
        })
    }
    
    // MARK: FUNCTIONS
    
    func connectToFirebase(name: String, email: String, provider: String, credential: AuthCredential) {
        
        AuthService.instance.logInUserToFirebase(credential: credential) { returnedProviderID, isError in
            
            if let providerID = returnedProviderID, !isError {
                // SUCCESS
            } else {
                // ERROR
                print("Error getting into from log in user to Firebase")
                self.showError.toggle()
            }
        }
        
    }
    
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
