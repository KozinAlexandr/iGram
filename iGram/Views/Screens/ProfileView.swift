//
//  ProfileView.swift
//  iGram
//
//  Created by Alexandr Kozin on 28.11.2022.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            ProfileHeaderView()
        })
        .navigationBarTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                Button(action: {
            
                                }, label: {
                                    Image(systemName: "line.horizontal.3")
                                })
                                    .accentColor(Color.MyTheme.purpleColor)
        )
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}
