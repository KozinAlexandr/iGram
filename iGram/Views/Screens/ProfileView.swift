//
//  ProfileView.swift
//  iGram
//
//  Created by Alexandr Kozin on 28.11.2022.
//

import SwiftUI

struct ProfileView: View {
    
    
    @State var profileDisplayName: String
    @State var showSettings: Bool = false
    
    var isMyProfile: Bool
    var profileUserID: String
    var posts = PostArrayObject()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            ProfileHeaderView(profileDisplayName: $profileDisplayName)
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
                                    .accentColor(Color.MyTheme.purpleColor)
                                    .opacity(isMyProfile ? 1.0 : 0.0)
        )
        .sheet(isPresented: $showSettings, content: {
            SettingsView()
        })
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(profileDisplayName: "Alex", isMyProfile: true, profileUserID: "")
        }
    }
}
