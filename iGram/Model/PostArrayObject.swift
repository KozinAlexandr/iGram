//
//  PostArrayObject.swift
//  iGram
//
//  Created by Alexandr Kozin on 20.11.2022.
//

import Foundation

class PostArrayObject: ObservableObject {
    
    @Published var dataArray = [PostModel]()
    
    init() {
        
        print("FETCH FROM DATABASE HERE")
        
        let post1 = PostModel(postID: "", userID: "", username: "Alex Kozin", caption: "Не бывает безвыходных ситуаций. Бывают ситуации, выход из которых тебя не устраивает.", dateCreated: Date(), likeCount: 0, likedByUser: false)
        let post2 = PostModel(postID: "", userID: "", username: "Alex Petrishchev", caption: "Так же известен под ником А.Г.П. Самый крутой фрик, которого я знаю.", dateCreated: Date(), likeCount: 0, likedByUser: false)
        let post3 = PostModel(postID: "", userID: "", username: "Nikita Simakov", caption: "Семейный человек.", dateCreated: Date(), likeCount: 0, likedByUser: false)
        let post4 = PostModel(postID: "", userID: "", username: "Kostya Lishenkov", caption: "Если Костя победит лень это будет не Костя, а КОТСТАНТИН!!!", dateCreated: Date(), likeCount: 0, likedByUser: false)
        
        self.dataArray.append(post1)
        self.dataArray.append(post2)
        self.dataArray.append(post3)
        self.dataArray.append(post4)
    }
    
    
    /// USED FOR SINGLE POST SELECTION
    init(post: PostModel) {
        self.dataArray.append(post)
    }
    
}
