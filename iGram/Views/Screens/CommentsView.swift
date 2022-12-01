//
//  CommentsView.swift
//  iGram
//
//  Created by Alexandr Kozin on 23.11.2022.
//

import SwiftUI

struct CommentsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var submissionText: String = ""
    @State var commentArray = [CommentModel]()
    
    @State var profilePicture: UIImage = UIImage(named: "logo.loading")!
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    @AppStorage(CurrentUserDefaults.displayName) var currentUserDisplayName: String?
    
    var post: PostModel
    
    var body: some View {
        VStack {
            
            // Messages scrollview
            ScrollView {
                LazyVStack {
                    ForEach(commentArray, id: \.self) { comment in
                        MessageView(comment: comment)
                    }
                }
            }
            
            // Botoom HStack
            HStack {
                
                Image(uiImage: profilePicture)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
                
                TextField("Add a comment here...", text: $submissionText)
                
                Button(action: {
                    if textIsAppropriate() {
                        addComment()
                    }
                }, label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                })
                .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
            }
            .padding(.all, 6)
        }
        .padding(.horizontal)
        .navigationBarTitle("Comments")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            getComments()
            getProfilePicture()
        })
    }
    
    // MARK: FUNCTIONS
    
    func getProfilePicture() {
        
        guard let userID = currentUserID else { return }
        
        ImageManager.instance.downloadProfileImage(userID: userID) { (returnedImage) in
            if let image = returnedImage {
                self.profilePicture = image
            }
        }
        
    }
    
    func getComments() {
        
        print("GET COMMENTS FROM DATABASE")
        
        let comment1 = CommentModel(commentID: "", userID: "", username: "Alex Kozin", content: "На ошибках учатся, после ошибок лечатся.", dataCreated: Date())
        let comment2 = CommentModel(commentID: "", userID: "", username: "Alex Petrishchev", content: "Прихожу на экзамен по чилить. Туда сюда кобанчиком, а экзамен, то по философии. Беру билет и первый вопрос: Столько это сколько ? Что было дальше и так знаете.", dataCreated: Date())
        let comment3 = CommentModel(commentID: "", userID: "", username: "Nikita Simakov", content: "Человеку нужна причина для существования, иначе жизнь ничем не будет отличаться от смерти.", dataCreated: Date())
        let comment4 = CommentModel(commentID: "", userID: "", username: "Kostya Lishenkov", content: "Только начнешь работать, обязательно кто-нибудь разбудит.", dataCreated: Date())
        
        self.commentArray.append(comment1)
        self.commentArray.append(comment2)
        self.commentArray.append(comment3)
        self.commentArray.append(comment4)
        
    }
    
    func textIsAppropriate() -> Bool {
        
        // Check if the text has curses
        // Check if the text is long enough
        // Check if the text is blank
        // Check for innapropriate things
        
        // Checking for bad words
        let badWordArray: [String] = ["shit", "ass"]
        
        let words = submissionText.components(separatedBy: " ")
        
        for word in words {
            if badWordArray.contains(word) {
                return false
            }
        }
        
        // Checking for minimum character count
        if submissionText.count < 3 {
            return false
        }
        
        return true
    }
    
    func addComment() {
        
        guard let userID = currentUserID, let displayName = currentUserDisplayName else { return }
        
        DataService.instance.uploadComment(postID: post.postID, content: submissionText, displayName: displayName, userID: userID) { (success, returnedCommentID) in
            
            if success, let commentID = returnedCommentID {
                
                let newComment = CommentModel(commentID: commentID, userID: userID, username: displayName, content: submissionText, dataCreated: Date())
                self.commentArray.append(newComment)
                self.submissionText = ""
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            
        }
        
    }
}

struct CommentsView_Previews: PreviewProvider {
    
    static let post = PostModel(postID: "asd", userID: "asd", username: "sad", dateCreated: Date(), likeCount: 0, likedByUser: false)
    
    static var previews: some View {
        NavigationView {
            CommentsView(post: post)
        }
    }
}
