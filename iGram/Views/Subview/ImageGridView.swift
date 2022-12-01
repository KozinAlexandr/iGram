//
//  ImageGridView.swift
//  iGram
//
//  Created by Alexandr Kozin on 27.11.2022.
//

import SwiftUI

struct ImageGridView: View {
    
    @ObservedObject var posts: PostArrayObject
    
    var body: some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible()),
            ],
            alignment: .center,
            spacing: nil,
            pinnedViews: [],
            content: {
                ForEach(posts.dataArray, id: \.self) { post in
                    
                    NavigationLink(
                        destination: FeedView(posts: PostArrayObject(post: post), title: "Post"),
                        label: {
                            PostView(post: post, addHeartAnimationToView: false, showHeaderAndFooter: false)
                        })
                }
            })
    }
}

struct ImageGridView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridView(posts: PostArrayObject(shuffled: true))
            .previewLayout(.sizeThatFits)
    }
}
