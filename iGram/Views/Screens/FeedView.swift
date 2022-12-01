//
//  FeedView.swift
//  iGram
//
//  Created by Alexandr Kozin on 20.11.2022.
//

import SwiftUI

struct FeedView: View {
    
    @ObservedObject var posts: PostArrayObject
    var title: String
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            LazyVStack {
                
                ForEach(posts.dataArray, id: \.self) { post in
                    PostView(post: post, addHeartAnimationToView: true, showHeaderAndFooter: true)
                }
            }
        })
        .navigationBarTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FeedView(posts: PostArrayObject(shuffled: false), title: "Feed Test")

        }
    }
}
