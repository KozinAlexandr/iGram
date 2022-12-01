//
//  LazyView.swift
//  iGram
//
//  Created by Alexandr Kozin on 01.12.2022.
//

import Foundation
import SwiftUI

struct LazyView<Content: View>: View {
    
    var content: () -> Content
    
    var body: some View {
        self.content()
    }
    
}
