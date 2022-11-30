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
                
                Image("cat2")
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
                .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
            }
            .padding(.all, 6)
        }
        .padding(.horizontal)
        .navigationBarTitle("Comments")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            getComments()
        })
    }
    
    // MARK: FUNCTIONS
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
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CommentsView()
        }
    }
}
