//
//  UploadView.swift
//  iGram
//
//  Created by Alexandr Kozin on 27.11.2022.
//

import SwiftUI
import UIKit

struct UploadView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var showImagePicker: Bool = false
    @State var imageSelected: UIImage = UIImage(named: "logo")!
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var showPostImageView: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                
                Button(action: {
                    sourceType = UIImagePickerController.SourceType.camera
                    showImagePicker.toggle()
                }, label: {
                    Text("Сделать фото".uppercased())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.MyTheme.yellowColor)
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(Color.MyTheme.purpleColor)
                
                Button(action: {
                    sourceType = UIImagePickerController.SourceType.photoLibrary
                    showImagePicker.toggle()
                }, label: {
                    Text("Импорт фото".uppercased())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.MyTheme.purpleColor)
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(Color.MyTheme.yellowColor)
                
            }
            .sheet(isPresented: $showImagePicker, onDismiss: segueToPostImageView, content: {
                ImagePicker(imageSelected: $imageSelected, sourceType: $sourceType)
                    .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
            })
        
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: .center)
                .shadow(radius: 12)
                .fullScreenCover(isPresented: $showPostImageView, content: {
                    PostImageView(imageSelected: $imageSelected)
                })
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    // MARK: FUNCTIONS
    
    func segueToPostImageView() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            showPostImageView.toggle()
        }
        
    }
    
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
