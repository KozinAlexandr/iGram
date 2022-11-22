//
//  CommentsView.swift
//  iGram
//
//  Created by Alexandr Kozin on 23.11.2022.
//

import SwiftUI

struct CommentsView: View {
    
    @State var submissionText: String = ""
    @State var commentArray = [CommentModel]()
    
    var body: some View {
        VStack {
            
            ScrollView {
                LazyVStack {
                    ForEach(commentArray, id: \.self) { comment in
                        MessageView(comment: comment)
                    }
                }
            }
            
            HStack {
                
                Image("dog1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
                
                TextField("Add a comment here...", text: $submissionText)
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                })
                .accentColor(Color.MyTheme.purpleColor)
            }
            .padding(.all, 6)
        }
        .navigationBarTitle("Comments")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            getComments()
        })
    }
    
    // MARK: FUNCTIONS
    
    func getComments() {
        
        print("GET COMMENTS FROM DATABASE")
        
        let comment1 = CommentModel(commentID: "", userID: "", username: "Alex Kozin", content: "This is the first comment", dataCreated: Date())
        let comment2 = CommentModel(commentID: "", userID: "", username: "Alex Petrishchev", content: "This is the second comment", dataCreated: Date())
        let comment3 = CommentModel(commentID: "", userID: "", username: "Nikita Simakov", content: "This is the third comment", dataCreated: Date())
        let comment4 = CommentModel(commentID: "", userID: "", username: "Kostya Lishenkov", content: "This is the fourth comment", dataCreated: Date())
        
        self.commentArray.append(comment1)
        self.commentArray.append(comment2)
        self.commentArray.append(comment3)
        self.commentArray.append(comment4)
        
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CommentsView()
        }
    }
}
