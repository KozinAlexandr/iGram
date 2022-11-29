//
//  PostView.swift
//  iGram
//
//  Created by Alexandr Kozin on 20.11.2022.
//

import SwiftUI

struct PostView: View {
    
    @State var post: PostModel
    @State var animateLike: Bool = false
    @State var addHeartAnimationToView: Bool
    
    var showHeaderAndFooter: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 0, content: {
            
            // MARK: HEADER
            if showHeaderAndFooter {
                HStack {
                    
                    NavigationLink(
                        destination: ProfileView(profileDisplayName: post.username, isMyProfile: false, profileUserID: post.userID),
                        label: {
                            Image("dog1")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30, alignment: .center)
                                .cornerRadius(15)
                            
                            Text(post.username)
                                .font(.callout)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                    })
                    
                    Spacer()
                    
                    Image(systemName: "ellipsis")
                        .font(.headline)
                    
                }
                .padding(.all, 6)
            }
            
            // MARK: IMAGE
            
            ZStack {
                Image("dog1")
                    .resizable()
                    .scaledToFit()
                
                if addHeartAnimationToView {
                    LikeAnimationView(animate: $animateLike)
                }
            }
        
            // MARK: FOOTER
            
            if showHeaderAndFooter {
                HStack(alignment: .center, spacing: 20, content: {
                    
                    Button(action: {
                        if post.likedByUser {
                            // unlike
                            unlikePost()
                        } else {
                            //like
                            likePost()
                        }
                    }, label: {
                        Image(systemName: post.likedByUser ? "heart.fill" : "heart")
                            .font(.title3)
                    })
                    .accentColor(post.likedByUser ? .red : .primary)
                    
                    
                    // MARK: COMMENT ICON
                    NavigationLink(
                        destination: CommentsView(),
                        label: {
                            Image(systemName: "bubble.middle.bottom")
                                .font(.title3)
                                .foregroundColor(.primary)
                        })
                    
                    
                    Image(systemName: "paperplane")
                        .font(.title3)
                    
                    Spacer()
                })
                .padding(.all, 6)
                
                if let caption = post.caption {
                    HStack {
                        Text(caption)
                        Spacer(minLength: 0)
                    }
                    .padding(.all, 6)
                }
            }
            
        })
    }
    
    // MARK: FUNCTIONS
    
    func likePost() {
        
        // Update the local data
        let updatedPost = PostModel(postID: post.postID, userID: post.userID, username: post.username, caption: post.caption, dateCreated: post.dateCreated, likeCount: post.likeCount + 1, likedByUser: true)
        self.post = updatedPost
        
        animateLike = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            animateLike = false
        }
        
    }
    
    func unlikePost() {
        
        // Update the local data
        let updatedPost = PostModel(postID: post.postID, userID: post.userID, username: post.username, caption: post.caption, dateCreated: post.dateCreated, likeCount: post.likeCount - 1, likedByUser: false)
        self.post = updatedPost
    }
    
}

struct PostView_Previews: PreviewProvider {
    
    static var post: PostModel = PostModel(postID: "", userID: "", username: "Alex Kozin", caption: "This is a test caption", dateCreated: Date(), likeCount: 0, likedByUser: false)
    
    static var previews: some View {
        PostView(post: post, addHeartAnimationToView: true, showHeaderAndFooter: true)
            .previewLayout(.sizeThatFits)
    }
}
