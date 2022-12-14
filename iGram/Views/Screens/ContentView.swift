//
//  ContentView.swift
//  iGram
//
//  Created by Alexandr Kozin on 20.11.2022.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    @AppStorage(CurrentUserDefaults.displayName) var currentUserDisplayName: String?
    
    let feedPosts = PostArrayObject(shuffled: false)
    let browsePosts = PostArrayObject(shuffled: true)
    
    var body: some View {
        TabView {
            NavigationView {
                FeedView(posts: feedPosts, title: "Лента")
            }
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Лента")
                }
            
            NavigationView {
                BrowseView(posts: browsePosts)
            }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Обозреватель")
                }
            
            UploadView()
                .tabItem {
                    Image(systemName: "square.and.arrow.up.fill")
                    Text("Загрузка")
                }
            
            ZStack {
                if let userID = currentUserID, let displayName = currentUserDisplayName {
                    NavigationView {
                        ProfileView(profileDisplayName: displayName, isMyProfile: true, profileUserID: userID, posts: PostArrayObject(userID: userID))
                    }
                } else {
                    SignUpView()
                }
            }
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Профиль")
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
