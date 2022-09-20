//
//  HideKeyboardExtension.swift
//  DevoteApp
//
//  Created by Usha Sai Chintha on 20/09/22.
//

import SwiftUI

#if canImport(UIKit)
extension View{
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
