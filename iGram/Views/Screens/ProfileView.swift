//
//  ProfileView.swift
//  iGram
//
//  Created by Alexandr Kozin on 28.11.2022.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var profileDisplayName: String
    @State var profileImage: UIImage = UIImage(named: "logo.loading")!
    @State var showSettings: Bool = false
    
    var isMyProfile: Bool
    var profileUserID: String
    var posts = PostArrayObject()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            ProfileHeaderView(profileDisplayName: $profileDisplayName, profileImage: $profileImage)
            Divider()
            ImageGridView(posts: posts)
        })
        .navigationBarTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    showSettings.toggle()
                                }, label: {
                                    Image(systemName: "line.horizontal.3")
                                })
                                    .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
                                    .opacity(isMyProfile ? 1.0 : 0.0)
        )
        .onAppear(perform: {
            getProfileImage()
        })
        .sheet(isPresented: $showSettings, content: {
            SettingsView()
        })
    }
    
    // MARK: FUNCTIONS
    
    func getProfileImage() {
        
        ImageManager.instance.downloadProfileImage(userID: profileUserID) { (returnedImage) in
            if let image = returnedImage {
                self.profileImage = image
            }
        }
        
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(profileDisplayName: "Alex", isMyProfile: true, profileUserID: "")
        }
    }
}
