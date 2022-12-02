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
    
    @Binding var userDisplayName: String
    @Binding var userBio: String
    @Binding var userProfilePicture: UIImage
    
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
                        
                        Text("iGram is an application for publishing your photos and sharing them around the world.  The application was created for coursework at the university")
                            .font(.footnote)
                    })
                })
                .padding()
                
                // MARK: SECTION 2: PROFILE
                GroupBox(label: SettingsLabelView(labelText: "Profile", labelImage: "person.fill"), content: {
                    
                    NavigationLink(
                        destination:
                            SettingsEditTextView(submissionText: userDisplayName, title: "Display Name", description: "You can edit your display name here. This will be seen by other users on your profile and on your posts!", placeholder: "Your display name here...", settingsEditTextOption: .displayName, profileText: $userDisplayName),
                        label: {
                            SettingsRowView(leftIcon: "pencil", text: "Display Name", color: Color.MyTheme.purpleColor)
                    })
                    
                    NavigationLink(
                        destination:
                            SettingsEditTextView(submissionText: userBio, title: "Profile Bio", description: "Your bio is a great place to let other users know a little about you. It will be shown on your profile only.", placeholder: "Your bio here...", settingsEditTextOption: .bio, profileText: $userBio),
                        label: {
                            SettingsRowView(leftIcon: "text.quote", text: "Bio", color: Color.MyTheme.purpleColor)
                    })
                    
                    NavigationLink(
                        destination: SettingsEditImageView(title: "Profile Picture", description: "Your profile picture will be shown on your profile and on your posts. Mosts users make it an image of themselves or of their who(?)!", selectedImage: userProfilePicture, profileImage: $userProfilePicture),
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
                
                // MARK: SECTION 3: LINKS
                GroupBox(label: SettingsLabelView(labelText: "Links", labelImage: "link"), content: {
                   
                    Button(action: {
                        openCustomURL(urlString: "https://github.com/KozinAlexandr/iGram")
                    }, label: {
                        SettingsRowView(leftIcon: "globe", text: "Project on Github", color: Color.MyTheme.yellowColor)
                    })
                    
                    // VK
                    
                    // Telegram
                    
                })
                .padding()
                
                // MARK: SECTION 4: APPLICATION
                GroupBox(label: SettingsLabelView(labelText: "Application", labelImage: "apps.iphone"), content: {
                    
                    Button(action: {
                        openCustomURL(urlString: "https://www.termsfeed.com/live/b268cc53-fa3f-4c30-a7b9-68347910a06a")
                    }, label: {
                        SettingsRowView(leftIcon: "folder.fill", text: "Privacy Policy", color: Color.MyTheme.yellowColor)
                    })
                    
                    Button(action: {
                        openCustomURL(urlString: "https://www.termsfeed.com/live/fd06098a-91a1-435e-b33e-19edddab82cd")
                    }, label: {
                        SettingsRowView(leftIcon: "folder.fill", text: "Terms & Conditions", color: Color.MyTheme.yellowColor)
                    })
                })
                .padding()
                
                
                // MARK: SECTION 5: SIGN OFF
                GroupBox {
                    Text("Pavlova set a test please \n iGram was made with love \n All Rights Reserved \n Copyright 2022 ❤️")
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
                
            } else {
                print("Error logging out")
                self.showSignOutError.toggle()
            }
        }
        
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    
    @State static var testString: String = ""
    @State static var image: UIImage = UIImage(named: "dog1")!
    
    static var previews: some View {
        SettingsView(userDisplayName: $testString, userBio: $testString, userProfilePicture: $image)
    }
}
