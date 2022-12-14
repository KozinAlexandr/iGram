//
//  SettingsView.swift
//  iGram
//
//  Created by Alexandr Kozin on 29.11.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    @State var showSignOutError: Bool = false
    
    @Binding var userDisplayName: String
    @Binding var userBio: String
    @Binding var userProfilePicture: UIImage
    //@Binding var userFeedback:String
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false, content: {
                
                // MARK: SECTION 1: IGRAM
                GroupBox(label: SettingsLabelView(labelText: "iGram", labelImage: "dot.radiowaves.left.and.right"), content: {
                    HStack(alignment: .center, spacing: 10, content: {
                        
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80, alignment: .center)
                            .cornerRadius(12)
                        
                        Text("iGram - это приложение для публикации ваших фотографий и обмена ими по всему миру.  Приложение было создано для курсовой работы в университете.")
                            .font(.footnote)
                    })
                })
                .padding()
                
                // MARK: SECTION 2: PROFILE
                GroupBox(label: SettingsLabelView(labelText: "Профиль", labelImage: "person.fill"), content: {
                    
                    NavigationLink(
                        destination:
                            SettingsEditTextView(submissionText: userDisplayName, title: "Отображаемое имя", description: "Вы можете изменить свое отображаемое имя здесь. Это увидят другие пользователи в вашем профиле и в ваших постах!", placeholder: "Ваше отображаемое имя здесь...", settingsEditTextOption: .displayName, profileText: $userDisplayName),
                        label: {
                            SettingsRowView(leftIcon: "pencil", text: "Отображаемое имя", color: colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
                    })
                    
                    NavigationLink(
                        destination:
                            SettingsEditTextView(submissionText: userBio, title: "Биография профиля", description: "Ваша биография — отличное место, чтобы другие пользователи могли немного узнать о вас. Он будет отображаться только в вашем профиле.", placeholder: "Ваша биография здесь...", settingsEditTextOption: .bio, profileText: $userBio),
                        label: {
                            SettingsRowView(leftIcon: "text.quote", text: "Биография", color: colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
                    })
                    
                    NavigationLink(
                        destination: SettingsEditImageView(title: "Фотография профиля", description: "Изображение вашего профиля будет отображаться в вашем профиле и в ваших сообщениях. Большинство пользователей делают это своим изображением!", selectedImage: userProfilePicture, profileImage: $userProfilePicture),
                        label: {
                            SettingsRowView(leftIcon: "photo", text: "Фотография профиля", color: colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
                        })
                    
                    NavigationLink(
                        destination:
                            SettingsEditTextView(submissionText: "", title: "Обратная связь", description: "Оставляя отзыв, вы помогаете создателю приложения в его продвижении и можете поблагодарить создателя или написать о найденной ошибке.", placeholder: "Ваша обратная связь здесь...", settingsEditTextOption: .bio, profileText: $userBio),
                        label: {
                            SettingsRowView(leftIcon: "message.fill", text: "Обратная связь", color: colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
                    })
                    
                    
                    Button(action: {
                        signOut()
                    }, label: {
                        SettingsRowView(leftIcon: "figure.walk", text: "Выход с аккаунта", color: colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
                    })
                    .alert(isPresented: $showSignOutError, content: {
                        return Alert(title: Text("Error signing out 🥵"))
                    })
                    
                })
                .padding()
                
                // MARK: SECTION 3: LINKS
                GroupBox(label: SettingsLabelView(labelText: "Ссылки", labelImage: "link"), content: {
                   
                    Button(action: {
                        openCustomURL(urlString: "https://github.com/KozinAlexandr/iGram")
                    }, label: {
                        SettingsRowView(leftIcon: "network", text: "Проект на GitHub", color: colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
                    })
                    
                    Button(action: {
                        openCustomURL(urlString: "https://t.me/argonauttz")
                    }, label: {
                        SettingsRowView(leftIcon: "signature", text: "Контакты", color: colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
                    })
                    
                    // Telegram
                    
                })
                .padding()
                
                // MARK: SECTION 4: APPLICATION
                GroupBox(label: SettingsLabelView(labelText: "Права", labelImage: "apps.iphone"), content: {
                    
                    Button(action: {
                        openCustomURL(urlString: "https://www.termsfeed.com/live/b268cc53-fa3f-4c30-a7b9-68347910a06a")
                    }, label: {
                        SettingsRowView(leftIcon: "folder.fill", text: "Политика конфиденциальности", color: colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
                    })
                    
                    Button(action: {
                        openCustomURL(urlString: "https://www.termsfeed.com/live/fd06098a-91a1-435e-b33e-19edddab82cd")
                    }, label: {
                        SettingsRowView(leftIcon: "folder.fill", text: "Положения & Условия", color: colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
                    })
                })
                .padding()
                
                
                // MARK: SECTION 5: SIGN OFF
                GroupBox {
                    Text("Павлова поставь зачет 😠 \n iGram сделан с любовью \n Все права защищены \n 2022")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .padding(.bottom, 80)
                
                
            })
            .navigationBarTitle("Настройки")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(leading:
                                    Button(action: {
                                        presentationMode.wrappedValue.dismiss()
                                    }, label: {
                                        Image(systemName: "xmark")
                                            .font(.title)
                                    })
                                        .accentColor(.primary)
            )
        }
        .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
    }
    
    // MARK: FUNCTIONS
    
    func openCustomURL(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    func signOut() {
        AuthService.instance.logOutUser { (success) in
            if success {
                print("Success logged out")
                
                // Dismiss settings view
                self.presentationMode.wrappedValue.dismiss()
                
            } else {
                print("Error logging out")
                self.showSignOutError.toggle()
            }
        }
        
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    
    @State static var testString: String = ""
    @State static var image: UIImage = UIImage(named: "dog1")!
    
    static var previews: some View {
        SettingsView(userDisplayName: $testString, userBio: $testString, userProfilePicture: $image)
    }
}
