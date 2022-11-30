//
//  ContentView.swift
//  iGram
//
//  Created by Alexandr Kozin on 20.11.2022.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    var currentUserID: String? = nil
    
    var body: some View {
        TabView {
            NavigationView {
                FeedView(posts: PostArrayObject(), title: "Feed")
            }
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Feed")
                }
            
            NavigationView {
                BrowseView()
            }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Browse")
                }
            
            UploadView()
                .tabItem {
                    Image(systemName: "square.and.arrow.up.fill")
                    Text("Upload")
                }
            
            ZStack {
                if currentUserID != nil {
                    NavigationView {
                        ProfileView(profileDisplayName: "My Profile", isMyProfile: true, profileUserID: "")
                    }
                } else {
                    SignUpView()
                }
            }
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
