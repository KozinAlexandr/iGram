//
//  SignInWithAppleButtonCustom.swift
//  iGram
//
//  Created by Alexandr Kozin on 29.11.2022.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct SignInWithAppleButtonCustom: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(authorizationButtonType: .default, authorizationButtonStyle: .black)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}
