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
    
    @State var displayName: String = ""
    @State var email: String = ""
    @State var providerID: String = ""
    @State var provider: String = ""
    
    var body: some View {
        VStack(spacing: 10) {
            
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
                .shadow(radius: 12)
            
            Text("Приветствую в iGram!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.MyTheme.purpleColor)
            
            Text("iGram - это приложение для публикации ваших фотографий и обмена ими по всему миру.  Приложение было создано для курсовой работы в университете.")
                .font(.headline)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.MyTheme.purpleColor)
                .padding()
            
            // MARK: SIGN IN WITH APPLE
            // doesn't work because there is no Apple subscription
            Button(action: {
                //showOnboardingPart2.toggle()
                SignInWithApple.instance.startSignInWithAppleFlow(view: self)
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
                    Image("google")
                        .resizable()
                        .frame(width: 25, height: 25)
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
                Text("Продолжить как гость".uppercased())
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
        .fullScreenCover(isPresented: $showOnboardingPart2, onDismiss: {
            self.presentationMode.wrappedValue.dismiss()
        }, content: {
            OnboardingViewPart2(displayName: $displayName, email: $email, providerID: $providerID, provider: $provider)
        })
        .alert(isPresented: $showError, content: {
            return Alert(title: Text("Error signing in 😔"))
        })
    }
    
    // MARK: FUNCTIONS
    
    func connectToFirebase(name: String, email: String, provider: String, credential: AuthCredential) {
        
        AuthService.instance.logInUserToFirebase(credential: credential) { (returnedProviderID, isError, isNewUser, returnedUserID) in
            if let newUser = isNewUser {
                if newUser {
                    // NEW USER
                    if let providerID = returnedProviderID, !isError {
                        // New user, continue to the onboarding part 2
                        self.displayName = name
                        self.email = email
                        self.providerID = providerID
                        self.provider = provider
                        self.showOnboardingPart2.toggle()
                    } else {
                        // ERROR
                        print("Error getting provider ID from log in user to Firebase")
                        self.showError.toggle()
                    }
                } else {
                    // EXISTING USER
                    if let userID = returnedUserID {
                        // SUCCESS, LOG IN TO APP
                        AuthService.instance.logInUserToApp(userID: userID) { (success) in
                            if success {
                                print("Succesful log in existing user")
                                self.presentationMode.wrappedValue.dismiss()
                            } else {
                                print("Error logging existing user into our app")
                                self.showError.toggle()
                            }
                        }
                    } else {
                        // ERROR
                        print("Error getting USER ID from existing user to Firebase")
                        self.showError.toggle()
                    }
                }
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
