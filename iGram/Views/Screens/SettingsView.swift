//
//  SettingsView.swift
//  iGram
//
//  Created by Alexandr Kozin on 29.11.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    @State var showSignOutError: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false, content: {
                
                // MARK: SECTION 1: IGRAM
                GroupBox(label: SettingsLabelView(labelText: "iGram", labelImage: "dot.radiowaves.left.and.right"), content: {
                    HStack(alignment: .center, spacing: 10, content: {
                        
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80, alignment: .center)
                            .cornerRadius(12)
                        
                        // Change na cours work
                        Text("iGram is the #1 app for posting pictures of your (who?) and sharing them across the world. We are a (who?)-loving community and we're happy to have you!")
                            .font(.footnote)
                    })
                })
                .padding()
                
                // MARK: SECTION 2: PROFILE
                GroupBox(label: SettingsLabelView(labelText: "Profile", labelImage: "person.fill"), content: {
                    
                    NavigationLink(
                        destination:
                            SettingsEditTextView(submissionText: "Current Display Name", title: "Display Name", description: "You can edit your display name here. This will be seen by other users on your profile and on your posts!", placeholder: "Your display name here..."),
                        label: {
                            SettingsRowView(leftIcon: "pencil", text: "Display Name", color: Color.MyTheme.purpleColor)
                    })
                    
                    NavigationLink(
                        destination:
                            SettingsEditTextView(submissionText: "Current Bio", title: "Profile Bio", description: "Your bio is a great place to let other users know a little about you. It will be shown on your profile only.", placeholder: "Your bio here..."),
                        label: {
                            SettingsRowView(leftIcon: "text.quote", text: "Bio", color: Color.MyTheme.purpleColor)
                    })
                    
                    NavigationLink(
                        destination: SettingsEditImageView(title: "Profile Picture", description: "Your profile picture will be shown on your profile and on your posts. Mosts users make it an image of themselves or of their who(?)!", selectedImage: UIImage(named: "dog1")!),
                        label: {
                            SettingsRowView(leftIcon: "photo", text: "Profile Picture", color: Color.MyTheme.purpleColor)
                        })
                    
                    Button(action: {
                        signOut()
                    }, label: {
                        SettingsRowView(leftIcon: "figure.walk", text: "Sign out", color: Color.MyTheme.purpleColor)
                    })
                    .alert(isPresented: $showSignOutError, content: {
                        return Alert(title: Text("Error signing out 🥵"))
                    })
                    
                })
                .padding()
                
                // MARK: SECTION 3: APPLICATION
                GroupBox(label: SettingsLabelView(labelText: "Application", labelImage: "apps.iphone"), content: {
                    //add github link on project
                    Button(action: {
                        openCustomURL(urlString: "https://www.google.com")
                    }, label: {
                        SettingsRowView(leftIcon: "folder.fill", text: "Privacy Policy", color: Color.MyTheme.yellowColor)
                    })
                    
                    Button(action: {
                        openCustomURL(urlString: "https://www.yahoo.com")
                    }, label: {
                        SettingsRowView(leftIcon: "folder.fill", text: "Terms & Conditions", color: Color.MyTheme.yellowColor)
                    })

                    
                    Button(action: {
                        openCustomURL(urlString: "https://github.com/KozinAlexandr/iGram")
                    }, label: {
                        SettingsRowView(leftIcon: "globe", text: "Project on Github", color: Color.MyTheme.yellowColor)
                    })
                })
                .padding()
                
                // MARK: SECTION 4: SIGN OFF
                GroupBox {
                    Text("iGram was made with love. \n All Rights Reserved \n Cool Apps Inc. \n Copyright 2022 ❤️")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .padding(.bottom, 80)
                
                
            })
            .navigationBarTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(leading:
                                    Button(action: {
                                        presentationMode.wrappedValue.dismiss()
                                    }, label: {
                                        Image(systemName: "xmark")
                                            .font(.title)
                                    })
                                        .accentColor(.primary)
            )
        }
        .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
    }
    
    // MARK: FUNCTIONS
    
    func openCustomURL(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    func signOut() {
        AuthService.instance.logOutUser { (success) in
            if success {
                print("Success logged out")
                
                // Dismiss settings view
                self.presentationMode.wrappedValue.dismiss()
                
                // Updated UserDefaults
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    
                    let defaultsDictionary = UserDefaults.standard.dictionaryRepresentation()
                    defaultsDictionary.keys.forEach { key in
                        UserDefaults.standard.removeObject(forKey: key)
                    }
                }
            } else {
                print("Error logging out")
                self.showSignOutError.toggle()
            }
        }
        
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
